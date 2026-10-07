import 'dart:async';
import 'dart:math' as math;
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurants_menu/common/extensions/extensions.dart';
import 'package:restaurants_menu/features/chat/domin/use_cases/send_voice_use_case.dart';
import 'package:restaurants_menu/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_ai_speaking_content.dart';
import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_disable_content.dart';
import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_failed_content.dart';
import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_listening_content.dart';
import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_loading_content.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:video_player/video_player.dart';

import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../core/di/injection.dart';

class HomeVideoVoiceChatWidget extends StatefulWidget {
  const HomeVideoVoiceChatWidget({super.key});

  @override
  State<HomeVideoVoiceChatWidget> createState() => _HomeVideoVoiceChatWidgetState();
}

class _HomeVideoVoiceChatWidgetState extends State<HomeVideoVoiceChatWidget>
    with SingleTickerProviderStateMixin {
  // ===========================================================================
  // CONTROLLERS
  // ===========================================================================

  late final stt.SpeechToText _speech;

  late final AudioPlayer _audioPlayer;

  late final ChatBloc _chatBloc;

  late final AnimationController _recordingAnimationController;

  // ===========================================================================
  // AVATAR VIDEO
  // ===========================================================================

  /// Idle / listening avatar clips. Add new files here (and to assets/videos/).
  static final List<String> _silentVideos = [
    Assets.videos.silent1,
    Assets.videos.silent2,
    Assets.videos.silent3,
    Assets.videos.silent4,
  ];

  /// Speaking avatar clips played while the AI audio is playing.
  static final List<String> _talkVideos = [
    Assets.videos.talk1,
    Assets.videos.talk2,
    Assets.videos.talk3,
    Assets.videos.talk4,
  ];

  /// The controller currently shown. Swapped only once the next one is ready.
  final ValueNotifier<VideoPlayerController?> _videoControllerNotifier =
      ValueNotifier<VideoPlayerController?>(null);

  /// Whether the clip on screen is a talk clip (true) or silent clip (false).
  bool? _videoIsTalk;

  /// Index of the clip last played in each category (-1 = none yet).
  int _currentListeningIndex = -1;

  int _currentSpeakingIndex = -1;

  /// Incremented on every switch so stale async initializations are discarded.
  int _videoRequestId = 0;

  // ===========================================================================
  // SUBSCRIPTIONS
  // ===========================================================================

  StreamSubscription<PlayerState>? _audioSubscription;

  // ===========================================================================
  // REACTIVE UI STATE
  // ===========================================================================

  late final ValueNotifier<bool> _voiceChatActiveNotifier;

  late final ValueNotifier<bool> _isSendingVoiceNotifier;

  late final ValueNotifier<bool> _userHasSpokenNotifier;

  late final ValueNotifier<double> _soundLevelNotifier;

  late final ValueNotifier<String> _speechTextNotifier;

  // ===========================================================================
  // INTERNAL SPEECH STATE
  // ===========================================================================

  bool _speechInitialized = false;

  bool _isStartingSpeech = false;

  bool _speechSessionActive = false;

  bool _restartScheduled = false;

  bool _recordingRequested = false;

  // ===========================================================================
  // INTERNAL AUDIO STATE
  // ===========================================================================

  bool _aiAudioActuallyPlaying = false;

  // ===========================================================================
  // SPEECH TEXT
  // ===========================================================================

  String _lastRecognizedText = '';

  String _speechTextBeforeCurrentSession = '';

  // ===========================================================================
  // TIMERS
  // ===========================================================================

  Timer? _silenceTimer;

  // ===========================================================================
  // SPEECH INFO
  // ===========================================================================

  DateTime? _lastUserSpeechAt;

  // ===========================================================================
  // CONFIG
  // ===========================================================================

  static const Duration _submitSilenceDuration = Duration(seconds: 2);

  static const Duration _speechPauseDuration = Duration(minutes: 30);

  static const Duration _speechListenDuration = Duration(minutes: 30);

  // ===========================================================================
  // SESSION
  // ===========================================================================

  int _recordingSessionId = 0;

  // ===========================================================================
  // GETTERS
  // ===========================================================================

  bool get _voiceChatActive => _voiceChatActiveNotifier.value;

  set _voiceChatActive(bool value) {
    _voiceChatActiveNotifier.value = value;
  }

  bool get _isSendingVoice => _isSendingVoiceNotifier.value;

  set _isSendingVoice(bool value) {
    _isSendingVoiceNotifier.value = value;
  }

  bool get _userHasSpoken => _userHasSpokenNotifier.value;

  set _userHasSpoken(bool value) {
    _userHasSpokenNotifier.value = value;
  }

  double get _soundLevel => _soundLevelNotifier.value;

  set _soundLevel(double value) {
    _soundLevelNotifier.value = value;
  }

  String get _speechText => _speechTextNotifier.value;

  set _speechText(String value) {
    _speechTextNotifier.value = value;
  }

  // ===========================================================================
  // INIT STATE
  // ===========================================================================

  @override
  void initState() {
    super.initState();

    // -------------------------------------------------------------------------
    // CONTROLLERS
    // -------------------------------------------------------------------------

    _speech = stt.SpeechToText();

    _audioPlayer = AudioPlayer();

    _chatBloc = getIt<ChatBloc>();

    _recordingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      lowerBound: 0,
      upperBound: 1,
    );

    // -------------------------------------------------------------------------
    // VALUE NOTIFIERS
    // -------------------------------------------------------------------------

    _voiceChatActiveNotifier = ValueNotifier<bool>(false);

    _isSendingVoiceNotifier = ValueNotifier<bool>(false);

    _userHasSpokenNotifier = ValueNotifier<bool>(false);

    _soundLevelNotifier = ValueNotifier<double>(0);

    _speechTextNotifier = ValueNotifier<String>('');

    // -------------------------------------------------------------------------
    // INITIALIZATION
    // -------------------------------------------------------------------------

    unawaited(_initializeAudio());

    unawaited(_initializeSpeech());
  }

  // ===========================================================================
  // SPEECH INITIALIZE
  // ===========================================================================

  Future<void> _initializeSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
      );

      if (!mounted) {
        return;
      }

      _speechInitialized = available;
    } catch (_) {
      _speechInitialized = false;
    }
  }

  // ===========================================================================
  // AUDIO INITIALIZE
  // ===========================================================================

  Future<void> _initializeAudio() async {
    try {
      final session = await AudioSession.instance;

      await session.configure(
         AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
          avAudioSessionMode: AVAudioSessionMode.voiceChat,
          avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
          AVAudioSessionCategoryOptions.allowBluetoothA2dp |
          AVAudioSessionCategoryOptions.defaultToSpeaker |
          AVAudioSessionCategoryOptions.mixWithOthers,
          androidAudioAttributes: AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            // `media` plays on the media stream (full volume); voiceCommunication
            // would use the much quieter call stream.
            usage: AndroidAudioUsage.media,
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
          androidWillPauseWhenDucked: false,
        ),
      );

      await session.setActive(true);
    } catch (_) {}

    if (!mounted) {
      return;
    }

    _audioSubscription = _audioPlayer.playerStateStream.listen((playerState) {
      if (!mounted) {
        return;
      }

      final processingState = playerState.processingState;
      final playing = playerState.playing;

      // ---------------------------------------------------------------------
      // AUDIO COMPLETED
      // ---------------------------------------------------------------------

      if (processingState == ProcessingState.completed) {
        if (!_aiAudioActuallyPlaying) {
          return;
        }

        _aiAudioActuallyPlaying = false;

        unawaited(_onAiAudioCompleted());

        return;
      }

      // ---------------------------------------------------------------------
      // AUDIO STARTED
      // ---------------------------------------------------------------------

      if (playing && !_aiAudioActuallyPlaying) {
        _aiAudioActuallyPlaying = true;
      }
    });
  }

  // ===========================================================================
  // SESSION
  // ===========================================================================

  void _invalidateRecordingSession() {
    _recordingSessionId++;

    _recordingRequested = false;

    _speechSessionActive = false;

    _isStartingSpeech = false;

    _restartScheduled = false;

  }

  // ===========================================================================
  // OPEN VOICE CHAT
  // ===========================================================================

  void _openVoiceChat() {
    if (!mounted) {
      return;
    }

    _voiceChatActive = true;

    _isSendingVoice = false;

    _recordingRequested = true;

    _userHasSpoken = false;

    _speechText = '';

    _lastRecognizedText = '';

    _speechTextBeforeCurrentSession = '';

    _chatBloc.add(SentListenEvent());

    unawaited(_startRecording());
  }

  // ===========================================================================
  // CLOSE VOICE CHAT
  // ===========================================================================

  Future<void> _closeVoiceChat() async {
    if (!mounted) {
      return;
    }

    _voiceChatActive = false;

    _invalidateRecordingSession();

    _cancelTimers();

    // -------------------------------------------------------------------------
    // STOP SPEECH
    // -------------------------------------------------------------------------

    try {
      if (_speech.isListening) {
        await _speech.cancel();
      }
    } catch (_) {}

    // -------------------------------------------------------------------------
    // STOP AI AUDIO
    // -------------------------------------------------------------------------

    try {
      _aiAudioActuallyPlaying = false;

      await _audioPlayer.stop();
    } catch (_) {}

    // -------------------------------------------------------------------------
    // CLEAR STATE
    // -------------------------------------------------------------------------

    _clearLocalData();

    _chatBloc.add(ResetVoiceEvent());

    _chatBloc.add(SentDisableEvent());
  }

  // ===========================================================================
  // CANCEL TIMERS
  // ===========================================================================

  void _cancelTimers() {
    _silenceTimer?.cancel();

    _silenceTimer = null;

    _restartScheduled = false;
  }

  // ===========================================================================
  // CLEAR LOCAL DATA
  // ===========================================================================

  void _clearLocalData() {
    _speechText = '';

    _lastRecognizedText = '';

    _speechTextBeforeCurrentSession = '';

    _soundLevel = 0;

    _userHasSpoken = false;

    _isStartingSpeech = false;

    _isSendingVoice = false;

    _speechSessionActive = false;

    _cancelTimers();

    _recordingAnimationController.stop();

    _recordingAnimationController.value = 0;

    _aiAudioActuallyPlaying = false;

  }

  // ===========================================================================
  // WAIT FOR SPEECH TO FINISH
  // ===========================================================================

  Future<void> _waitForSpeechToFinish() async {
    try {
      if (_speech.isListening) {
        await _speech.cancel();
      }
    } catch (_) {}

    for (int i = 0; i < 20; i++) {
      if (!mounted) {
        return;
      }

      if (!_speech.isListening) {
        break;
      }

      await Future<void>.delayed(const Duration(milliseconds: 100));
    }

    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  // ===========================================================================
  // START RECORDING
  // ===========================================================================

  Future<void> _startRecording({bool force = false}) async {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    if (_isSendingVoice) {
      return;
    }

    if (_speechSessionActive && !force) {
      return;
    }

    if (_isStartingSpeech) {
      return;
    }

    final sessionId = ++_recordingSessionId;

    _isStartingSpeech = true;

    _recordingRequested = true;

    _speechSessionActive = false;

    _speechTextBeforeCurrentSession = _speechText.trim();

    _lastRecognizedText = '';

    try {
      // -----------------------------------------------------------------------
      // MICROPHONE PERMISSION
      // -----------------------------------------------------------------------

      final permission = await Permission.microphone.request();

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      if (!permission.isGranted) {
        _recordingRequested = false;

        _speechSessionActive = false;

        _chatBloc.add(SentFailedEvent());

        return;
      }

      // -----------------------------------------------------------------------
      // WAIT FOR PREVIOUS SESSION
      // -----------------------------------------------------------------------

      if (_speech.isListening) {
        await _waitForSpeechToFinish();
      }

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      // -----------------------------------------------------------------------
      // INITIALIZE SPEECH IF NEEDED
      // -----------------------------------------------------------------------

      if (!_speechInitialized) {
        final available = await _speech.initialize(
          onStatus: _onSpeechStatus,
          onError: _onSpeechError,
        );

        if (!mounted || sessionId != _recordingSessionId) {
          return;
        }

        if (!available) {
          _recordingRequested = false;

          _speechSessionActive = false;

          _chatBloc.add(SentFailedEvent());

          return;
        }

        _speechInitialized = true;
      }

      // -----------------------------------------------------------------------
      // ENSURE LISTENING STATE
      // -----------------------------------------------------------------------

      if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
        _chatBloc.add(SentListenEvent());

        await Future<void>.delayed(const Duration(milliseconds: 50));
      }

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      // -----------------------------------------------------------------------
      // START STT
      // -----------------------------------------------------------------------

      _speechSessionActive = true;

      await _speech.listen(
        listenOptions: stt.SpeechListenOptions(
          localeId: Localizations.localeOf(context).toString(),
          listenFor: _speechListenDuration,
          pauseFor: _speechPauseDuration,
          partialResults: true,
          cancelOnError: false,
          listenMode: stt.ListenMode.dictation,
        ),
        onSoundLevelChange: _onSoundLevelChange,
        onResult: _onSpeechResult,
      );

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      _speechSessionActive = true;
    } catch (_) {
      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      _speechSessionActive = false;
    } finally {
      _isStartingSpeech = false;
    }
  }

  // ===========================================================================
  // SPEECH STATUS
  // ===========================================================================

  void _onSpeechStatus(String status) {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    if (status == 'listening') {
      _speechSessionActive = true;

      return;
    }

    if (status == 'done' || status == 'notListening') {
      _speechSessionActive = false;

      if (_isSendingVoice ||
          _isStartingSpeech ||
          !_recordingRequested ||
          _chatBloc.state.voiceChatState != VoiceChatState.listening) {
        return;
      }

      // The recognizer ended on its own: submit what the user said, or
      // reopen the mic if nothing was heard.
      final message = _speechText.trim();

      if (_userHasSpoken && message.isNotEmpty) {
        unawaited(_finishUserSpeechAndSend(message));

        return;
      }

      _scheduleRestartListening();
    }
  }

  // ===========================================================================
  // RESTART LISTENING
  // ===========================================================================

  void _scheduleRestartListening() {
    if (_restartScheduled) {
      return;
    }

    _restartScheduled = true;

    Future<void>.delayed(const Duration(milliseconds: 400), () {
      _restartScheduled = false;

      if (!mounted ||
          !_voiceChatActive ||
          _isSendingVoice ||
          _isStartingSpeech ||
          !_recordingRequested ||
          _speech.isListening ||
          _chatBloc.state.voiceChatState != VoiceChatState.listening) {
        return;
      }

      unawaited(_startRecording(force: true));
    });
  }

  // ===========================================================================
  // SPEECH ERROR
  // ===========================================================================

  void _onSpeechError(dynamic error) {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    _speechSessionActive = false;

    final errorText = error.toString();

    if (errorText.contains('error_busy')) {
      return;
    }

    if (_recordingRequested && !_isSendingVoice) {
      // No-match / timeout: just reopen the mic instead of getting stuck.
      _scheduleRestartListening();

      return;
    }

    _chatBloc.add(SentFailedEvent());
  }

  // ===========================================================================
  // SOUND LEVEL
  // ===========================================================================

  void _onSoundLevelChange(double level) {
    if (!mounted || !_voiceChatActive || _isSendingVoice) {
      return;
    }

    if (!_speechSessionActive) {
      return;
    }

    if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
      return;
    }

    _soundLevel = level;
  }

  // ===========================================================================
  // MERGE SPEECH TEXT
  // ===========================================================================

  String _mergeSpeechText(String recognizedText) {
    final current = recognizedText.trim();

    if (current.isEmpty) {
      return _speechTextBeforeCurrentSession;
    }

    final base = _speechTextBeforeCurrentSession.trim();

    if (base.isEmpty) {
      return current;
    }

    if (current.startsWith(base)) {
      return current;
    }

    if (base == current) {
      return base;
    }

    return '$base $current'.trim();
  }

  // ===========================================================================
  // SPEECH RESULT
  // ===========================================================================

  void _onSpeechResult(dynamic result) {
    if (!mounted) {
      return;
    }

    final current = result.recognizedWords.trim();

    if (!_voiceChatActive || current.isEmpty) {
      return;
    }

    if (!_speechSessionActive && !_speech.isListening) {
      return;
    }

    if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
      return;
    }

    final mergedText = _mergeSpeechText(current);

    if (mergedText == _lastRecognizedText) {
      return;
    }

    _lastRecognizedText = mergedText;

    _speechText = mergedText;

    _userHasSpoken = true;

    _lastUserSpeechAt = DateTime.now();

    try {
      _speech.changePauseFor(_speechPauseDuration);
    } catch (_) {}

    _startSilenceTimer();
  }

  // ===========================================================================
  // SILENCE TIMER
  // ===========================================================================

  void _startSilenceTimer() {
    _silenceTimer?.cancel();

    if (!_userHasSpoken) {
      return;
    }

    final session = _recordingSessionId;

    _silenceTimer = Timer(_submitSilenceDuration, () async {
      if (!mounted || !_voiceChatActive || _isSendingVoice || !_userHasSpoken) {
        return;
      }

      if (session != _recordingSessionId) {
        return;
      }

      final lastSpeech = _lastUserSpeechAt;

      if (lastSpeech != null) {
        final elapsed = DateTime.now().difference(lastSpeech);

        if (elapsed < _submitSilenceDuration) {
          _startSilenceTimer();

          return;
        }
      }

      final message = _speechText.trim();

      if (message.isEmpty) {
        return;
      }

      await _finishUserSpeechAndSend(message);
    });
  }

  // ===========================================================================
  // FINISH USER SPEECH
  // ===========================================================================

  Future<void> _finishUserSpeechAndSend(String message) async {
    if (!mounted || _isSendingVoice) {
      return;
    }

    final text = message.trim();

    if (text.isEmpty) {
      return;
    }

    _silenceTimer?.cancel();

    _silenceTimer = null;

    _recordingRequested = false;

    _speechSessionActive = false;

    _userHasSpoken = false;

    try {
      if (_speech.isListening) {
        await _speech.stop();
      }
    } catch (_) {}

    if (!mounted) {
      return;
    }

    await _sendVoiceMessage(text);
  }

  // ===========================================================================
  // SEND VOICE MESSAGE
  // ===========================================================================

  Future<void> _sendVoiceMessage(String message) async {
    if (!mounted) {
      return;
    }

    final text = message.trim();

    if (text.isEmpty || _isSendingVoice) {
      return;
    }

    _isSendingVoice = true;

    _recordingRequested = false;

    _speechSessionActive = false;

    _userHasSpoken = false;

    _speechText = '';

    _lastRecognizedText = '';

    _speechTextBeforeCurrentSession = '';

    _soundLevel = 0;

    _chatBloc.add(SentLoadingEvent());

    _chatBloc.add(SendVoiceEvent(params: SendVoiceParams(message: text)));
  }

  // ===========================================================================
  // PLAY AI AUDIO
  // ===========================================================================

  Future<void> _playAiAudio(String answer) async {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    try {
      final url = _extractAudioUrl(answer);

      // -----------------------------------------------------------------------
      // NO AUDIO URL
      // -----------------------------------------------------------------------

      if (url == null || url.isEmpty) {
        _isSendingVoice = false;

        _recordingRequested = true;

        _chatBloc.add(SentListenEvent());

        await _startRecording(force: true);

        return;
      }

      // -----------------------------------------------------------------------
      // INVALIDATE USER SESSION
      // -----------------------------------------------------------------------

      _aiAudioActuallyPlaying = false;

      _recordingRequested = false;

      _speechSessionActive = false;

      _isStartingSpeech = false;

      _restartScheduled = false;

      _recordingSessionId++;

      // Fresh buffers for the AI turn.
      _userHasSpoken = false;

      _speechText = "";

      _lastRecognizedText = "";

      _speechTextBeforeCurrentSession = "";

      _soundLevel = 0;

      // -----------------------------------------------------------------------
      // STOP STT
      // -----------------------------------------------------------------------

      try {
        if (_speech.isListening) {
          await _speech.cancel();
        }
      } catch (_) {}

      await _waitForSpeechToFinish();

      if (!mounted || !_voiceChatActive) {
        return;
      }

      // -----------------------------------------------------------------------
      // STOP PREVIOUS AUDIO
      // -----------------------------------------------------------------------

      try {
        await _audioPlayer.stop();
      } catch (_) {}

      if (!mounted || !_voiceChatActive) {
        return;
      }

      // -----------------------------------------------------------------------
      // LOAD AUDIO
      // -----------------------------------------------------------------------

      await _audioPlayer.setUrl(url);

      if (!mounted || !_voiceChatActive) {
        return;
      }

      // -----------------------------------------------------------------------
      // PLAY AI AUDIO
      // -----------------------------------------------------------------------

      final session = await AudioSession.instance;
      await session.setActive(true);

      // Full volume, then start playback. The mic/STT was already released above.
      await _audioPlayer.setVolume(1.0);

      unawaited(_audioPlayer.play());
    } catch (error, stackTrace) {
      debugPrint('AI audio playback failed: $error');
      debugPrint(stackTrace.toString());

      if (!mounted) {
        return;
      }

      _aiAudioActuallyPlaying = false;

      _isSendingVoice = false;

      _recordingRequested = true;

      _chatBloc.add(SentListenEvent());

      await _startRecording(force: true);
    }
  }

  // ===========================================================================
  // STOP AI AUDIO
  // ===========================================================================

  Future<void> _stopAiAudio() async {
    if (!mounted) {
      return;
    }

    // -------------------------------------------------------------------------
    // INVALIDATE AI SESSION
    // -------------------------------------------------------------------------

    _aiAudioActuallyPlaying = false;

    _recordingRequested = false;

    _speechSessionActive = false;

    _isStartingSpeech = false;

    _restartScheduled = false;

    _recordingSessionId++;

    // -------------------------------------------------------------------------
    // STOP AUDIO
    // -------------------------------------------------------------------------

    try {
      await _audioPlayer.stop();
    } catch (_) {}

    // -------------------------------------------------------------------------
    // STOP OLD STT
    // -------------------------------------------------------------------------

    try {
      if (_speech.isListening) {
        await _speech.cancel();
      }
    } catch (_) {}

    await _waitForSpeechToFinish();

    if (!mounted || !_voiceChatActive) {
      return;
    }

    // -------------------------------------------------------------------------
    // RESET USER SESSION
    // -------------------------------------------------------------------------

    _isSendingVoice = false;

    _userHasSpoken = false;

    _speechText = '';

    _lastRecognizedText = '';

    _speechTextBeforeCurrentSession = '';

    _soundLevel = 0;

    // -------------------------------------------------------------------------
    // GO TO LISTENING
    // -------------------------------------------------------------------------

    _chatBloc.add(SentListenEvent());

    _recordingRequested = true;

    await _startRecording(force: true);
  }

  // ===========================================================================
  // AI AUDIO COMPLETED
  // ===========================================================================

  Future<void> _onAiAudioCompleted() async {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    // -------------------------------------------------------------------------
    // INVALIDATE AI STATE
    // -------------------------------------------------------------------------

    _aiAudioActuallyPlaying = false;

    _isSendingVoice = false;

    _recordingRequested = true;

    _speechSessionActive = false;

    _isStartingSpeech = false;

    _restartScheduled = false;

    // -------------------------------------------------------------------------
    // RESET USER SESSION
    // -------------------------------------------------------------------------

    _userHasSpoken = false;

    _speechText = '';

    _lastRecognizedText = '';

    _speechTextBeforeCurrentSession = '';

    _soundLevel = 0;

    _recordingSessionId++;

    // -------------------------------------------------------------------------
    // CLOSE OLD STT
    // -------------------------------------------------------------------------

    await _waitForSpeechToFinish();

    if (!mounted || !_voiceChatActive) {
      return;
    }

    // -------------------------------------------------------------------------
    // LISTENING
    // -------------------------------------------------------------------------

    _chatBloc.add(SentListenEvent());

    await _startRecording(force: true);
  }

  // ===========================================================================
  // AUDIO URL
  // ===========================================================================

  String? _extractAudioUrl(String value) {
    final text = value.trim();

    if (text.isEmpty) {
      return null;
    }

    // -------------------------------------------------------------------------
    // MARKDOWN URL
    // -------------------------------------------------------------------------

    final markdownMatch = RegExp(r'\]\((https?:\/\/[^)]+)\)').firstMatch(text);

    if (markdownMatch != null) {
      return markdownMatch.group(1);
    }

    // -------------------------------------------------------------------------
    // PLAIN URL
    // -------------------------------------------------------------------------

    final urlMatch = RegExp(r'https?:\/\/[^\s]+').firstMatch(text);

    return urlMatch?.group(0);
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // ---------------------------------------------------------------------
        // AVATAR VIDEO FOLLOWS THE VOICE CHAT STATE
        // ---------------------------------------------------------------------
        BlocListener<ChatBloc, ChatState>(
          bloc: _chatBloc,
          listenWhen: (previous, current) =>
              previous.voiceChatState != current.voiceChatState,
          listener: (context, state) {
            unawaited(_syncVideoWithState(state.voiceChatState));
          },
        ),
        BlocListener<ChatBloc, ChatState>(
          bloc: _chatBloc,
          listenWhen: (previous, current) {
            return previous.voiceChatState != VoiceChatState.aiSpeaking &&
                current.voiceChatState == VoiceChatState.aiSpeaking;
          },
          listener: (context, state) {
            final answer = state.voiceData.data?.data?.answer;

            // -----------------------------------------------------------------
            // NO ANSWER
            // -----------------------------------------------------------------

            if (answer == null || answer.trim().isEmpty) {
              _isSendingVoice = false;

              _recordingRequested = true;

              _chatBloc.add(SentListenEvent());

              unawaited(_startRecording(force: true));

              return;
            }

            // -----------------------------------------------------------------
            // PLAY AI
            // -----------------------------------------------------------------

            unawaited(_playAiAudio(answer.trim()));
          },
        ),
      ],
      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: _chatBloc,
        builder: (context, state) {
          return _buildMainContainer(state);
        },
      ),
    );
  }

  // ===========================================================================
  // AVATAR VIDEO
  // ===========================================================================

  Future<void> _syncVideoWithState(VoiceChatState voiceState) async {
    if (!mounted) {
      return;
    }

    if (voiceState == VoiceChatState.disable) {
      await _releaseVideo();

      return;
    }

    final wantTalk = voiceState == VoiceChatState.aiSpeaking;

    // Listening -> loading -> failed keep playing the same silent sequence.
    if (_videoIsTalk == wantTalk && _videoControllerNotifier.value != null) {
      return;
    }

    await _switchVideo(talk: wantTalk);
  }

  List<String> _videoList(bool talk) => talk ? _talkVideos : _silentVideos;

  Future<void> _switchVideo({required bool talk}) async {
    final requestId = ++_videoRequestId;

    final list = _videoList(talk);
    final currentIndex = talk ? _currentSpeakingIndex : _currentListeningIndex;

    // Sequential: continue with the next clip of this category.
    final index = (currentIndex + 1) % list.length;
    final path = list[index];

    final controller = VideoPlayerController.asset(
      path,
      // Never grab audio focus: the AI audio owns the audio session.
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    try {
      await controller.initialize();
      await controller.setVolume(0);

      // A single clip loops; several clips play one after another.
      await controller.setLooping(list.length == 1);

      // A newer request, or dispose, happened while we were initializing.
      if (!mounted || requestId != _videoRequestId) {
        await controller.dispose();

        return;
      }

      await controller.play();
    } catch (_) {
      await controller.dispose();

      return;
    }

    // When the clip ends, move on to the next one in the same category.
    if (list.length > 1) {
      var finished = false;

      controller.addListener(() {
        final value = controller.value;

        if (finished ||
            !value.isInitialized ||
            value.duration == Duration.zero ||
            value.position < value.duration) {
          return;
        }

        finished = true;

        // Ignore clips that were already replaced.
        if (_videoControllerNotifier.value != controller) {
          return;
        }

        unawaited(_switchVideo(talk: talk));
      });
    }

    // Swap only once the new clip is ready so the avatar never flashes empty.
    final previous = _videoControllerNotifier.value;

    _videoControllerNotifier.value = controller;
    _videoIsTalk = talk;

    if (talk) {
      _currentSpeakingIndex = index;
    } else {
      _currentListeningIndex = index;
    }

    // Dispose after the frame that stops referencing the old controller.
    if (previous != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(previous.dispose());
      });
    }
  }

  Future<void> _releaseVideo() async {
    _videoRequestId++;

    final previous = _videoControllerNotifier.value;

    _videoControllerNotifier.value = null;
    _videoIsTalk = null;

    if (previous != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(previous.dispose());
      });
    }
  }

  // ===========================================================================
  // MAIN CONTAINER
  // ===========================================================================

  Widget _buildMainContainer(ChatState state) {
    final isDisable = state.voiceChatState == VoiceChatState.disable;

    if (!isDisable) {
      return _buildVideoCard(state);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal:isDisable?16: 14,
        vertical: isDisable ? 16 : 10,
      ),
      decoration: BoxDecoration(
        color: isDisable ? context.primarySwatch : null,
        gradient: LinearGradient(
          colors: [context.primarySwatch.derivedColor, context.primarySwatch, context.primarySwatch],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(5000),
        boxShadow: [
          BoxShadow(
            color: context.primarySwatch.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _buildStateContent(state),
      ),
    );
  }

  // ===========================================================================
  // STATE CONTENT
  // ===========================================================================

  Widget _buildStateContent(ChatState state) {
    switch (state.voiceChatState) {
      case VoiceChatState.disable:
        return VoiceDisableContent(onTap: _openVoiceChat);

      case VoiceChatState.listening:
        return VoiceListeningContent(
          onClose: _closeVoiceChat,
          animation: _recordingAnimationController,
        );

      case VoiceChatState.loading:
        return VoiceLoadingContent(onClose: _closeVoiceChat);

      case VoiceChatState.aiSpeaking:
        return VoiceAiSpeakingContent(
          onStop: _stopAiAudio,
          onClose: _closeVoiceChat,
        );

      case VoiceChatState.failed:
        return VoiceFailedContent(
          onRetry: _retryVoiceChat,
          onClose: _closeVoiceChat,
        );
    }
  }

  // ===========================================================================
  // VIDEO CARD (ACTIVE CHAT)
  // ===========================================================================

  Widget _buildVideoCard(ChatState state) {
    // Sized from the screen so it scales in portrait and landscape.
    final screen = MediaQuery.sizeOf(context);
    final isLandscape = screen.width > screen.height;

    final height = isLandscape ? screen.height * .45 : screen.height * .25;
    final width = math.min(height * .75, screen.width * .4);

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // -----------------------------------------------------------------
            // AVATAR VIDEO
            // -----------------------------------------------------------------
            ValueListenableBuilder<VideoPlayerController?>(
              valueListenable: _videoControllerNotifier,
              builder: (context, controller, _) {
                if (controller == null || !controller.value.isInitialized) {
                  return const SizedBox.shrink();
                }

                return FittedBox(
                  fit: BoxFit.cover,
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                );
              },
            ),

            // -----------------------------------------------------------------
            // STOP SPEAKING (ONLY WHILE THE AI IS SPEAKING)
            // -----------------------------------------------------------------
            if (state.voiceChatState == VoiceChatState.aiSpeaking)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: _stopAiAudio,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.stop_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              ),

            // -----------------------------------------------------------------
            // CLOSE BUTTON
            // -----------------------------------------------------------------
            PositionedDirectional(
              top: 6,
              end: 6,
              child: GestureDetector(
                onTap: _closeVoiceChat,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // RETRY
  // ===========================================================================

  void _retryVoiceChat() {
    if (!mounted) {
      return;
    }

    _isSendingVoice = false;

    _recordingRequested = true;

    _voiceChatActive = true;

    _speechText = '';

    _speechTextBeforeCurrentSession = '';

    _lastRecognizedText = '';

    _chatBloc.add(SentListenEvent());

    unawaited(_startRecording(force: true));
  }

  // ===========================================================================
  // DISPOSE
  // ===========================================================================

  @override
  void dispose() {
    _voiceChatActive = false;

    _recordingRequested = false;

    _speechSessionActive = false;

    _recordingSessionId++;

    _aiAudioActuallyPlaying = false;

    _isStartingSpeech = false;

    _cancelTimers();

    // -------------------------------------------------------------------------
    // SPEECH
    // -------------------------------------------------------------------------

    try {
      _speech.cancel();
    } catch (_) {}

    // -------------------------------------------------------------------------
    // AUDIO
    // -------------------------------------------------------------------------

    _audioSubscription?.cancel();

    _audioPlayer.dispose();

    // -------------------------------------------------------------------------
    // ANIMATION
    // -------------------------------------------------------------------------

    _recordingAnimationController.dispose();

    // -------------------------------------------------------------------------
    // VIDEO
    // -------------------------------------------------------------------------

    _videoRequestId++;

    final videoController = _videoControllerNotifier.value;

    _videoControllerNotifier.value = null;

    _videoControllerNotifier.dispose();

    unawaited(videoController?.dispose());

    // -------------------------------------------------------------------------
    // VALUE NOTIFIERS
    // -------------------------------------------------------------------------

    _voiceChatActiveNotifier.dispose();

    _isSendingVoiceNotifier.dispose();

    _userHasSpokenNotifier.dispose();

    _soundLevelNotifier.dispose();

    _speechTextNotifier.dispose();

    super.dispose();
  }
}

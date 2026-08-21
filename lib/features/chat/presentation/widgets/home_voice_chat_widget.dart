import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/features/chat/domin/use_cases/send_voice_use_case.dart';
import 'package:restaurants_menu/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../core/di/injection.dart';

class HomeVoiceChatWidget extends StatefulWidget {
  const HomeVoiceChatWidget({super.key});

  @override
  State<HomeVoiceChatWidget> createState() => _HomeVoiceChatWidgetState();
}

class _HomeVoiceChatWidgetState extends State<HomeVoiceChatWidget>
    with SingleTickerProviderStateMixin {
  // ===========================================================================
  // CONTROLLERS
  // ===========================================================================

  final stt.SpeechToText _speech = stt.SpeechToText();

  final AudioPlayer _audioPlayer = AudioPlayer();

  late final ChatBloc _chatBloc;

  late final AnimationController _recordingAnimationController;

  StreamSubscription<PlayerState>? _audioSubscription;

  // ===========================================================================
  // LOCAL STATE
  // ===========================================================================

  bool _speechInitialized = false;

  bool _isStartingSpeech = false;

  bool _isSendingVoice = false;

  bool _recordingRequested = false;

  bool _speechSessionActive = false;

  int _recordingSessionId = 0;

  double _soundLevel = 0;

  String _speechText = '';

  String _lastRecognizedText = '';

  // ===========================================================================
  // SPEECH SESSION START TIME
  // ===========================================================================

  DateTime? _speechSessionStartedAt;

  // ===========================================================================
  // IMPORTANT
  //
  // This is different from AudioPlayer.processingState.
  //
  // processingState can already be "completed" from a PREVIOUS audio.
  //
  // We only consider the current audio as completed if we have actually
  // observed playing=true for that audio.
  // ===========================================================================

  bool _aiAudioActuallyPlaying = false;

  // ===========================================================================
  // INIT
  // ===========================================================================

  @override
  void initState() {
    super.initState();

    _chatBloc = getIt<ChatBloc>();

    _recordingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      lowerBound: 0,
      upperBound: 1,
    );

    _initializeSpeech();

    _initializeAudio();
  }

  // ===========================================================================
  // DEBUG
  // ===========================================================================

  void _log(String message) {
    debugPrint(
      '[VOICE] ${DateTime.now().toIso8601String()} | '
      'session=$_recordingSessionId | '
      'requested=$_recordingRequested | '
      'active=$_speechSessionActive | '
      'starting=$_isStartingSpeech | '
      'sending=$_isSendingVoice | '
      'bloc=${_chatBloc.state.voiceChatState} | '
      '$message',
    );
  }

  void _logAudio(String message) {
    debugPrint(
      '[VOICE AUDIO] ${DateTime.now().toIso8601String()} | '
      'session=$_recordingSessionId | '
      'requested=$_recordingRequested | '
      'active=$_speechSessionActive | '
      'starting=$_isStartingSpeech | '
      'sending=$_isSendingVoice | '
      'bloc=${_chatBloc.state.voiceChatState} | '
      'actuallyPlaying=$_aiAudioActuallyPlaying | '
      '$message',
    );
  }

  // ===========================================================================
  // SPEECH INITIALIZE
  // ===========================================================================

  Future<void> _initializeSpeech() async {
    _log('INITIALIZE SPEECH');

    try {
      final available = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
      );

      if (!mounted) {
        return;
      }

      _speechInitialized = available;

      _log(
        'SPEECH INITIALIZED | '
        'available=$available',
      );
    } catch (e) {
      _speechInitialized = false;

      _log('SPEECH INITIALIZATION ERROR | error=$e');
    }
  }

  // ===========================================================================
  // AUDIO
  // ===========================================================================

  void _initializeAudio() {
    _logAudio('INITIALIZE AUDIO LISTENER');

    _audioSubscription = _audioPlayer.playerStateStream.listen((playerState) {
      if (!mounted) {
        return;
      }

      _logAudio(
        'AUDIO STATE | '
        'processing=${playerState.processingState} | '
        'playing=${playerState.playing}',
      );

      // =======================================================================
      // AUDIO REALLY STARTED
      // =======================================================================

      if (playerState.playing) {
        if (!_aiAudioActuallyPlaying) {
          _aiAudioActuallyPlaying = true;

          _logAudio('>>> AI AUDIO REALLY STARTED PLAYING <<<');
        }
      }

      // =======================================================================
      // AUDIO COMPLETED
      // =======================================================================

      if (playerState.processingState == ProcessingState.completed) {
        // =====================================================================
        // IMPORTANT
        //
        // AudioPlayer may emit "completed" immediately because the previous
        // audio was already completed.
        //
        // If we never observed playing=true for the current audio,
        // this completed event must be ignored.
        // =====================================================================

        if (!_aiAudioActuallyPlaying) {
          _logAudio(
            'COMPLETED IGNORED -> '
            'NO AUDIO WAS ACTUALLY PLAYING',
          );

          return;
        }

        _logAudio('>>> REAL AI AUDIO COMPLETED <<<');

        // Prevent duplicate completed callbacks.
        _aiAudioActuallyPlaying = false;

        _logAudio('CALL _onAiAudioCompleted()');

        _onAiAudioCompleted();
      }
    });
  }

  // ===========================================================================
  // OPEN
  // ===========================================================================

  void _openVoiceChat() {
    if (!mounted) {
      return;
    }

    HapticFeedback.lightImpact();

    _log('UI -> OPEN VOICE CHAT');

    _chatBloc.add(SentInitEvent());
  }

  // ===========================================================================
  // CLOSE
  // ===========================================================================

  Future<void> _closeVoiceChat() async {
    if (!mounted) {
      return;
    }

    HapticFeedback.lightImpact();

    _log('UI -> CLOSE VOICE CHAT');

    _invalidateRecordingSession();

    try {
      _log('CLOSE -> speech.cancel()');

      await _speech.cancel();
    } catch (e) {
      _log('CLOSE -> speech.cancel() ERROR | $e');
    }

    try {
      _logAudio('CLOSE -> audio.stop()');

      _aiAudioActuallyPlaying = false;

      await _audioPlayer.stop();
    } catch (e) {
      _logAudio('CLOSE -> audio.stop() ERROR | $e');
    }

    _clearLocalData();

    _chatBloc.add(ResetVoiceEvent());

    _chatBloc.add(SentDisableEvent());
  }

  // ===========================================================================
  // INVALIDATE SESSION
  // ===========================================================================

  void _invalidateRecordingSession() {
    final oldSession = _recordingSessionId;

    _recordingSessionId++;

    _recordingRequested = false;

    _speechSessionActive = false;

    _isStartingSpeech = false;

    _speechSessionStartedAt = null;

    _log(
      'INVALIDATE SESSION | '
      'old=$oldSession | '
      'new=$_recordingSessionId',
    );
  }

  // ===========================================================================
  // CLEAR LOCAL DATA
  // ===========================================================================

  void _clearLocalData() {
    _log('CLEAR LOCAL DATA');

    _speechText = '';

    _lastRecognizedText = '';

    _soundLevel = 0;

    _isStartingSpeech = false;

    _isSendingVoice = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _recordingAnimationController.stop();

    _recordingAnimationController.value = 0;
  }

  // ===========================================================================
  // START RECORDING
  // ===========================================================================

  Future<void> _startRecording() async {
    if (!mounted) {
      return;
    }

    _log('START RECORDING requested');

    if (_isStartingSpeech) {
      _log('START IGNORED -> already starting');

      return;
    }

    if (_isSendingVoice) {
      _log('START IGNORED -> currently sending');

      return;
    }

    final currentState = _chatBloc.state.voiceChatState;

    if (currentState != VoiceChatState.init &&
        currentState != VoiceChatState.failed) {
      _log(
        'START IGNORED -> invalid BLoC state | '
        'state=$currentState',
      );

      return;
    }

    // =========================================================================
    // NEW SESSION
    // =========================================================================

    final int sessionId = ++_recordingSessionId;

    _isStartingSpeech = true;

    _recordingRequested = true;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _speechText = '';

    _lastRecognizedText = '';

    _soundLevel = 0;

    _log(
      'NEW RECORDING SESSION STARTED | '
      'sessionId=$sessionId | '
      'speech.isListening=${_speech.isListening}',
    );

    try {
      // =======================================================================
      // PERMISSION
      // =======================================================================

      _log('REQUEST MICROPHONE PERMISSION');

      final permission = await Permission.microphone.request();

      if (!mounted || sessionId != _recordingSessionId) {
        _log(
          'PERMISSION RESULT IGNORED -> '
          'session changed',
        );

        return;
      }

      _log(
        'MICROPHONE PERMISSION RESULT | '
        'permission=$permission | '
        'granted=${permission.isGranted}',
      );

      if (!permission.isGranted) {
        _recordingRequested = false;

        _speechSessionActive = false;

        _isStartingSpeech = false;

        _chatBloc.add(SentFailedEvent());

        return;
      }

      // =======================================================================
      // CLEAN PREVIOUS SPEECH SESSION
      // =======================================================================

      _log(
        'CHECK PREVIOUS SPEECH | '
        'isListening=${_speech.isListening}',
      );

      try {
        if (_speech.isListening) {
          _log('PREVIOUS SPEECH IS LISTENING -> cancel()');

          await _speech.cancel();

          _log(
            'PREVIOUS SPEECH CANCELLED | '
            'isListening=${_speech.isListening}',
          );
        }
      } catch (e) {
        _log('PREVIOUS SPEECH cancel() ERROR | $e');
      }

      if (!mounted || sessionId != _recordingSessionId) {
        _log(
          'AFTER PREVIOUS SPEECH CLEANUP -> '
          'SESSION CHANGED',
        );

        return;
      }

      // =======================================================================
      // INITIALIZE SPEECH
      // =======================================================================

      if (!_speechInitialized) {
        _log('SPEECH NOT INITIALIZED -> initialize()');

        final available = await _speech.initialize(
          onStatus: _onSpeechStatus,
          onError: _onSpeechError,
        );

        if (!mounted || sessionId != _recordingSessionId) {
          _log(
            'SPEECH INITIALIZE RESULT IGNORED -> '
            'session changed',
          );

          return;
        }

        if (!available) {
          _log('SPEECH INITIALIZE FAILED');

          _recordingRequested = false;

          _speechSessionActive = false;

          _isStartingSpeech = false;

          _chatBloc.add(SentFailedEvent());

          return;
        }

        _speechInitialized = true;

        _log('SPEECH INITIALIZED SUCCESSFULLY');
      }

      // =======================================================================
      // CHANGE BLOC STATE
      // =======================================================================

      _log('SEND SentListenEvent');

      _chatBloc.add(SentListenEvent());

      await Future<void>.delayed(Duration.zero);

      if (!mounted ||
          sessionId != _recordingSessionId ||
          !_recordingRequested) {
        _log(
          'AFTER SentListenEvent -> START ABORTED | '
          'sessionId=$sessionId | '
          'currentSession=$_recordingSessionId | '
          'requested=$_recordingRequested',
        );

        return;
      }

      // =======================================================================
      // START SPEECH
      // =======================================================================

      _log(
        'CALL speech.listen() | '
        'sessionId=$sessionId | '
        'currentState=${_chatBloc.state.voiceChatState}',
      );

      await _speech.listen(
        listenOptions: stt.SpeechListenOptions(
          localeId: Localizations.localeOf(context).toString(),
          listenFor: const Duration(minutes: 5),
          pauseFor: const Duration(seconds: 5),
          partialResults: true,
        ),
        onSoundLevelChange: _onSoundLevelChange,
        onResult: _onSpeechResult,
      );

      _log(
        'speech.listen() RETURNED | '
        'sessionId=$sessionId | '
        'isListening=${_speech.isListening}',
      );

      if (!mounted ||
          sessionId != _recordingSessionId ||
          !_recordingRequested) {
        _log(
          'speech.listen() RESULT IGNORED | '
          'sessionId=$sessionId | '
          'currentSession=$_recordingSessionId | '
          'requested=$_recordingRequested',
        );

        return;
      }

      // =======================================================================
      // SPEECH SESSION REALLY ACTIVE
      // =======================================================================

      _speechSessionActive = true;

      _speechSessionStartedAt = DateTime.now();

      _log(
        '!!! SPEECH SESSION REALLY ACTIVE !!! | '
        'session=$sessionId | '
        'startedAt=$_speechSessionStartedAt | '
        'isListening=${_speech.isListening}',
      );
    } catch (e) {
      _log('START RECORDING ERROR | error=$e');

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      _recordingRequested = false;

      _speechSessionActive = false;

      _speechSessionStartedAt = null;

      _isStartingSpeech = false;

      _speechText = '';

      _lastRecognizedText = '';

      _soundLevel = 0;

      _recordingAnimationController.stop();

      _recordingAnimationController.value = 0;

      _chatBloc.add(SentFailedEvent());
    } finally {
      if (sessionId == _recordingSessionId) {
        _isStartingSpeech = false;

        _log(
          'START RECORDING FINALLY | '
          'session=$sessionId',
        );
      }
    }
  }

  // ===========================================================================
  // STOP RECORDING
  // ===========================================================================

  Future<void> _stopRecording() async {
    if (!mounted) {
      return;
    }

    _log(
      'USER STOP RECORDING | '
      'text="$_speechText" | '
      'isListening=${_speech.isListening}',
    );

    _recordingRequested = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _isStartingSpeech = false;

    _recordingSessionId++;

    _log(
      'USER STOP -> speech.stop() | '
      'newSession=$_recordingSessionId',
    );

    try {
      await _speech.stop();

      _log(
        'USER STOP -> speech.stop() DONE | '
        'isListening=${_speech.isListening}',
      );
    } catch (e) {
      _log('USER STOP -> speech.stop() ERROR | $e');
    }

    if (!mounted) {
      return;
    }

    final message = _speechText.trim();

    _log(
      'USER STOP -> FINAL MESSAGE | '
      'message="$message"',
    );

    if (message.isEmpty) {
      _log('USER STOP -> EMPTY MESSAGE -> RETURN INIT');

      await _returnToInit();

      return;
    }

    await _sendVoiceMessage(message);
  }

  // ===========================================================================
  // SPEECH STATUS
  // ===========================================================================

  void _onSpeechStatus(String status) {
    if (!mounted) {
      return;
    }

    _log(
      '>>> SPEECH STATUS CALLBACK <<< | '
      'status="$status" | '
      'isListening=${_speech.isListening}',
    );

    // =========================================================================
    // Ignore callbacks when user did not request recording.
    // =========================================================================

    if (!_recordingRequested) {
      _log(
        'STATUS IGNORED -> recordingRequested=false | '
        'status=$status',
      );

      return;
    }

    // =========================================================================
    // While starting, status callbacks are not reliable.
    // =========================================================================

    if (_isStartingSpeech) {
      _log(
        'STATUS IGNORED -> isStartingSpeech=true | '
        'status=$status',
      );

      return;
    }

    // =========================================================================
    // The new speech session MUST actually be active.
    // =========================================================================

    if (!_speechSessionActive) {
      _log(
        'STATUS IGNORED -> speechSessionActive=false | '
        'status=$status',
      );

      return;
    }

    // =========================================================================
    // Delayed callback protection.
    // =========================================================================

    final startedAt = _speechSessionStartedAt;

    if (startedAt == null) {
      _log(
        'STATUS IGNORED -> startedAt=null | '
        'status=$status',
      );

      return;
    }

    final elapsed = DateTime.now().difference(startedAt);

    const staleCallbackProtection = Duration(milliseconds: 800);

    if (elapsed < staleCallbackProtection) {
      _log(
        'STATUS IGNORED -> stale callback protection | '
        'status=$status | '
        'elapsed=${elapsed.inMilliseconds}ms',
      );

      return;
    }

    // =========================================================================
    // Only these statuses mean recognition ended.
    // =========================================================================

    if (status != 'done' && status != 'notListening') {
      _log(
        'STATUS IGNORED -> status is not terminal | '
        'status=$status',
      );

      return;
    }

    // =========================================================================
    // If recognizer is still listening, do not terminate current session.
    // =========================================================================

    if (_speech.isListening) {
      _log(
        'STATUS IGNORED -> speech.isListening=true | '
        'status=$status',
      );

      return;
    }

    // =========================================================================
    // Must still be in listening state.
    // =========================================================================

    if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
      _log(
        'STATUS IGNORED -> BLoC is not listening | '
        'status=$status',
      );

      return;
    }

    _log(
      'STATUS ACCEPTED -> SPEECH SESSION FINISHED | '
      'status=$status',
    );

    _recordingRequested = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _handleSpeechFinished();
  }

  // ===========================================================================
  // SPEECH FINISHED
  // ===========================================================================

  Future<void> _handleSpeechFinished() async {
    if (!mounted) {
      return;
    }

    _log(
      'HANDLE SPEECH FINISHED | '
      'text="$_speechText"',
    );

    _recordingRequested = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _isStartingSpeech = false;

    final message = _speechText.trim();

    if (message.isEmpty) {
      _log('SPEECH FINISHED -> EMPTY -> RETURN INIT');

      await _returnToInit();

      return;
    }

    try {
      _log('SPEECH FINISHED -> speech.stop()');

      await _speech.stop();
    } catch (e) {
      _log('SPEECH FINISHED -> speech.stop() ERROR | $e');
    }

    if (!mounted) {
      return;
    }

    await _sendVoiceMessage(message);
  }

  // ===========================================================================
  // SPEECH ERROR
  // ===========================================================================

  void _onSpeechError(dynamic error) {
    if (!mounted) {
      return;
    }

    _log(
      '>>> SPEECH ERROR <<< | '
      'error=$error',
    );

    if (!_recordingRequested &&
        _chatBloc.state.voiceChatState != VoiceChatState.listening) {
      _log(
        'SPEECH ERROR IGNORED -> '
        'not recording and not listening',
      );

      return;
    }

    _recordingRequested = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _isStartingSpeech = false;

    _speechText = '';

    _lastRecognizedText = '';

    _soundLevel = 0;

    _isSendingVoice = false;

    _recordingAnimationController.stop();

    _recordingAnimationController.value = 0;

    _chatBloc.add(SentFailedEvent());
  }

  // ===========================================================================
  // SOUND LEVEL
  // ===========================================================================

  void _onSoundLevelChange(double level) {
    if (!mounted) {
      return;
    }

    if (!_recordingRequested) {
      return;
    }

    if (!_speechSessionActive) {
      return;
    }

    if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
      return;
    }

    setState(() {
      _soundLevel = level;
    });
  }

  // ===========================================================================
  // SPEECH RESULT
  // ===========================================================================

  void _onSpeechResult(dynamic result) {
    if (!mounted) {
      return;
    }

    _log(
      'SPEECH RESULT | '
      '"${result.recognizedWords}" | '
      'final=${result.finalResult}',
    );

    if (!_recordingRequested) {
      _log('RESULT IGNORED -> recordingRequested=false');

      return;
    }

    if (!_speechSessionActive) {
      _log('RESULT IGNORED -> speechSessionActive=false');

      return;
    }

    if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
      _log('RESULT IGNORED -> BLoC is not listening');

      return;
    }

    final current = result.recognizedWords.trim();

    if (current.isEmpty) {
      return;
    }

    if (current == _lastRecognizedText) {
      _log(
        'RESULT IGNORED -> duplicate text | '
        '"$current"',
      );

      return;
    }

    _lastRecognizedText = current;

    _speechText = current;

    _log(
      'SPEECH TEXT UPDATED | '
      '"$_speechText"',
    );
  }

  // ===========================================================================
  // SEND VOICE
  // ===========================================================================

  Future<void> _sendVoiceMessage(String message) async {
    if (!mounted) {
      return;
    }

    if (_isSendingVoice) {
      _log('SEND IGNORED -> already sending');

      return;
    }

    final text = message.trim();

    if (text.isEmpty) {
      _log('SEND IGNORED -> empty text');

      await _returnToInit();

      return;
    }

    _log(
      '!!! SEND VOICE MESSAGE !!! | '
      'text="$text"',
    );

    _recordingRequested = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _isStartingSpeech = false;

    _speechText = '';

    _lastRecognizedText = '';

    _soundLevel = 0;

    _isSendingVoice = true;

    _log('BLOC -> SentLoadingEvent');

    _chatBloc.add(SentLoadingEvent());

    _log('BLOC -> SendVoiceEvent');

    _chatBloc.add(SendVoiceEvent(params: SendVoiceParams(message: text)));
  }

  // ===========================================================================
  // RETURN INIT
  // ===========================================================================

  Future<void> _returnToInit() async {
    if (!mounted) {
      return;
    }

    _log('RETURN TO INIT');

    _invalidateRecordingSession();

    try {
      if (_speech.isListening) {
        _log('RETURN INIT -> speech.stop()');

        await _speech.stop();
      }
    } catch (e) {
      _log('RETURN INIT -> speech.stop() ERROR | $e');
    }

    try {
      _aiAudioActuallyPlaying = false;

      await _audioPlayer.stop();
    } catch (e) {
      _logAudio('RETURN INIT -> audio.stop() ERROR | $e');
    }

    _clearLocalData();

    _chatBloc.add(SentInitEvent());
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      bloc: _chatBloc,
      listenWhen: (previous, current) {
        return previous.voiceChatState != VoiceChatState.aiSpeaking &&
            current.voiceChatState == VoiceChatState.aiSpeaking;
      },
      listener: (context, state) {
        _log('!!! BLOC TRANSITION -> aiSpeaking !!!');

        final answer = state.voiceData.data?.data?.answer;

        _log(
          'AI SPEAKING LISTENER | '
          'answer=$answer',
        );

        if (answer == null || answer.trim().isEmpty) {
          _log('AI ANSWER EMPTY -> RETURN INIT');

          _returnToInit();

          return;
        }

        _playAiAudio(answer.trim());
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: _chatBloc,
        builder: (context, state) {
          return _buildMainContainer(state);
        },
      ),
    );
  }

  // ===========================================================================
  // MAIN CONTAINER
  // ===========================================================================

  Widget _buildMainContainer(ChatState state) {
    final isDisable = state.voiceChatState == VoiceChatState.disable;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      padding:  EdgeInsets.symmetric(horizontal: 14, vertical:isDisable?14: 10),
      decoration: BoxDecoration(
        color: isDisable ? context.primarySwatch : null,
        gradient: LinearGradient(
                colors: [
                  context.primarySwatch.derivedColor,
                  context.primarySwatch,
                ],
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
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
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
        return _buildDisableContent();

      case VoiceChatState.init:
        return _buildInitContent();

      case VoiceChatState.listening:
        return _buildListeningContent();

      case VoiceChatState.loading:
        return _buildLoadingContent();

      case VoiceChatState.aiSpeaking:
        return _buildAiSpeakingContent();

      case VoiceChatState.failed:
        return _buildFailedContent();
    }
  }

  // ===========================================================================
  // DISABLE
  // ===========================================================================

  Widget _buildDisableContent() {
    return GestureDetector(
      key: const ValueKey('disableContent'),
      onTap: _openVoiceChat,
      child: Assets.images.png.robot.image(
        height: 24,
        color: context.cardColor,
      ),
    );
  }

  // ===========================================================================
  // INIT
  // ===========================================================================

  Widget _buildInitContent() {
    return Row(
      key: const ValueKey('initContent'),
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();

            _log('UI -> MIC TAP');

            _startRecording();
          },
          child: _buildCircleIcon(Icons.mic_rounded),
        ),
        const SizedBox(width: 12),
        Text(LocaleKeys.chatTalkNow.tr(), style: context.bodyMedium(color: context.cardColor)),
        const SizedBox(width: 12),
        _buildBackButton(),
      ],
    );
  }

  // ===========================================================================
  // LISTENING
  // ===========================================================================

  Widget _buildListeningContent() {
    return Row(
      key: const ValueKey('listeningContent'),
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();

            _log('UI -> STOP MIC TAP');

            _stopRecording();
          },
          child: _buildCircleIcon(Icons.mic_rounded, isRecording: true),
        ),
        const SizedBox(width: 12),
        Text(
          LocaleKeys.audioRecording.tr(),
          style: context.bodyMedium(color: context.cardColor),
        ),
        const SizedBox(width: 12),
        _buildBackButton(),
      ],
    );
  }

  // ===========================================================================
  // LOADING
  // ===========================================================================

  Widget _buildLoadingContent() {
    return Row(
      key: const ValueKey('loadingContent'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const SizedBox(
            width: 21,
            height: 21,
            child: CircularProgressIndicator(
              strokeWidth: 2.3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 12),
         Text(
            LocaleKeys.chatThinking.tr(),
          style: context.bodyMedium(color: context.cardColor),
        ),
        const SizedBox(width: 12),
        _buildBackButton(),
      ],
    );
  }

  // ===========================================================================
  // AI SPEAKING
  // ===========================================================================

  Widget _buildAiSpeakingContent() {
    return Row(
      key: const ValueKey('aiSpeakingContent'),
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _stopAiAudio,
          child: _buildCircleIcon(Icons.stop_rounded),
        ),
        const SizedBox(width: 12),
        SizedBox(height: 45,
    width: context.width*.3
    // width: context.isMobile
    // ? context.width*.3
    //     : context.isTablet
    // ? context.width * .7
    //     : context.width * .5

            , child: AiWaveWidget()),
        const SizedBox(width: 8),
        _buildBackButton(),
      ],
    );
  }

  // ===========================================================================
  // FAILED
  // ===========================================================================

  Widget _buildFailedContent() {
    return Row(
      key: const ValueKey('failedContent'),
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();

            _log('UI -> TRY AGAIN');

            _isSendingVoice = false;

            _recordingRequested = false;

            _speechSessionActive = false;

            _isStartingSpeech = false;

            _recordingSessionId++;

            _startRecording();
          },
          child: _buildCircleIcon(Icons.refresh_rounded),
        ),
        const SizedBox(width: 12),
        Text(LocaleKeys.retryChat.tr(), style: context.bodyMedium(color: context.cardColor)),
        const SizedBox(width: 12),
        _buildBackButton(),
      ],
    );
  }

  // ===========================================================================
  // PLAY AI AUDIO
  // ===========================================================================

  Future<void> _playAiAudio(String answer) async {
    try {
      _logAudio(
        'PLAY AI AUDIO START | '
        'answer="$answer"',
      );

      final url = _extractAudioUrl(answer);

      if (url == null || url.isEmpty) {
        _logAudio('AUDIO URL INVALID -> RETURN INIT');

        await _returnToInit();

        return;
      }

      _logAudio(
        'EXTRACT AUDIO URL | '
        'url=$url',
      );

      // =========================================================================
      // IMPORTANT
      //
      // Reset this BEFORE stop().
      //
      // Otherwise a previous completed state could be mistaken as the
      // completion of the new audio.
      // =========================================================================

      _aiAudioActuallyPlaying = false;

      _logAudio('RESET _aiAudioActuallyPlaying=false');

      // =========================================================================
      // STOP PREVIOUS PLAYER
      // =========================================================================

      _logAudio('AUDIO stop()');

      await _audioPlayer.stop();

      if (!mounted) {
        return;
      }

      // =========================================================================
      // SET NEW URL
      // =========================================================================

      _logAudio('AUDIO setUrl()');

      await _audioPlayer.setUrl(url);

      if (!mounted) {
        return;
      }

      _logAudio(
        'AUDIO setUrl() DONE | '
        'processing=${_audioPlayer.processingState} | '
        'playing=${_audioPlayer.playing}',
      );

      // =========================================================================
      // PLAY
      // =========================================================================

      _logAudio('AUDIO play()');

      await _audioPlayer.play();

      _logAudio(
        'AUDIO play() RETURNED | '
        'processing=${_audioPlayer.processingState} | '
        'playing=${_audioPlayer.playing}',
      );
    } catch (e) {
      _logAudio('PLAY AUDIO ERROR | error=$e');

      if (!mounted) {
        return;
      }

      _aiAudioActuallyPlaying = false;

      _isSendingVoice = false;

      await _returnToInit();
    }
  }

  // ===========================================================================
  // STOP AI AUDIO
  // ===========================================================================

  Future<void> _stopAiAudio() async {
    _logAudio('USER STOP AI AUDIO');

    // =========================================================================
    // IMPORTANT
    //
    // stop() may lead to a completed state.
    // We don't want that completed state to call _onAiAudioCompleted().
    // =========================================================================

    _aiAudioActuallyPlaying = false;

    _logAudio('USER STOP -> _aiAudioActuallyPlaying=false');

    try {
      await _audioPlayer.stop();

      _logAudio('USER STOP -> audio.stop() DONE');
    } catch (e) {
      _logAudio('USER STOP -> audio.stop() ERROR | $e');
    }

    if (!mounted) {
      return;
    }

    _invalidateRecordingSession();

    _isSendingVoice = false;

    _speechText = '';

    _lastRecognizedText = '';

    _soundLevel = 0;

    _chatBloc.add(SentInitEvent());

    _chatBloc.add(ResetVoiceEvent());
  }

  // ===========================================================================
  // AI AUDIO COMPLETED
  // ===========================================================================

  Future<void> _onAiAudioCompleted() async {
    if (!mounted) {
      return;
    }

    _logAudio('====================================================');

    _logAudio('!!! AI AUDIO COMPLETED !!!');

    _logAudio(
      'Previous session before invalidate | '
      'session=$_recordingSessionId | '
      'speechListening=${_speech.isListening}',
    );

    // =========================================================================
    // Completely invalidate the previous recording session.
    // =========================================================================

    _invalidateRecordingSession();

    _isSendingVoice = false;

    _speechText = '';

    _lastRecognizedText = '';

    _soundLevel = 0;

    _recordingAnimationController.stop();

    _recordingAnimationController.value = 0;

    // =========================================================================
    // IMPORTANT
    //
    // This should normally be false here.
    //
    // But if for any reason an old SpeechToText session is still alive,
    // cancel it before returning to init.
    // =========================================================================

    if (_speech.isListening) {
      _logAudio('AUDIO COMPLETED -> OLD SPEECH STILL LISTENING -> cancel()');

      try {
        await _speech.cancel();

        _logAudio(
          'AUDIO COMPLETED -> OLD SPEECH CANCELLED | '
          'isListening=${_speech.isListening}',
        );
      } catch (e) {
        _logAudio('AUDIO COMPLETED -> speech.cancel() ERROR | $e');
      }
    } else {
      _logAudio('AUDIO COMPLETED -> no active old speech session');
    }

    if (!mounted) {
      return;
    }

    _logAudio('AUDIO COMPLETED -> ResetAfterFinishVoiceEvent');

    _chatBloc.add(ResetAfterFinishVoiceEvent());

    _logAudio('====================================================');
  }

  // ===========================================================================
  // EXTRACT AUDIO URL
  // ===========================================================================

  String? _extractAudioUrl(String value) {
    final text = value.trim();

    if (text.isEmpty) {
      return null;
    }

    final markdownMatch = RegExp(r'\]\((https?:\/\/[^)]+)\)').firstMatch(text);

    if (markdownMatch != null) {
      return markdownMatch.group(1);
    }

    final urlMatch = RegExp(r'https?:\/\/[^\s]+').firstMatch(text);

    if (urlMatch != null) {
      return urlMatch.group(0);
    }

    return null;
  }

  // ===========================================================================
  // BACK BUTTON
  // ===========================================================================

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: _closeVoiceChat,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  // ===========================================================================
  // CIRCLE ICON
  // ===========================================================================

  Widget _buildCircleIcon(IconData icon, {bool isRecording = false}) {
    final circle = Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 25),
    );

    if (!isRecording) {
      return circle;
    }

    if (!_recordingAnimationController.isAnimating) {
      _recordingAnimationController.repeat(reverse: true);
    }

    return AnimatedBuilder(
      animation: _recordingAnimationController,
      child: circle,
      builder: (context, child) {
        final value = _recordingAnimationController.value;

        final scale = 0.94 + (value * 0.10);

        final opacity = 0.70 + (value * 0.30);

        return Transform.scale(
          scale: scale,
          child: Opacity(opacity: opacity, child: child),
        );
      },
    );
  }

  // ===========================================================================
  // DISPOSE
  // ===========================================================================

  @override
  void dispose() {
    _log('DISPOSE');

    _recordingRequested = false;

    _speechSessionActive = false;

    _speechSessionStartedAt = null;

    _recordingSessionId++;

    _aiAudioActuallyPlaying = false;

    try {
      _speech.cancel();
    } catch (_) {}

    _audioSubscription?.cancel();

    _audioPlayer.dispose();

    _recordingAnimationController.dispose();

    super.dispose();
  }
}

// =============================================================================
// AI WAVE
// =============================================================================

class AiWaveWidget extends StatefulWidget {
  const AiWaveWidget({super.key});

  @override
  State<AiWaveWidget> createState() => _AiWaveWidgetState();
}

class _AiWaveWidgetState extends State<AiWaveWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(14, (index) {
            final progress = (_controller.value + (index * 0.09)) % 1.0;

            final wave = (math.sin(progress * math.pi * 2) + 1) / 2;

            final height = 7 + (wave * 28);

            return Container(
              width: 4,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }),
        );
      },
    );
  }
}

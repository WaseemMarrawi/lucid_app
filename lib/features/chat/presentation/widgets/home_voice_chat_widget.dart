// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:restaurants_menu/common/extensions/extensions.dart';
// import 'package:restaurants_menu/features/chat/domin/use_cases/send_voice_use_case.dart';
// import 'package:restaurants_menu/features/chat/presentation/bloc/chat_bloc.dart';
// import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_ai_speaking_content.dart';
// import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_disable_content.dart';
// import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_failed_content.dart';
// import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_listening_content.dart';
// import 'package:restaurants_menu/features/chat/presentation/widgets/voice_chat_widgets/voice_loading_content.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// import '../../../../common/extensions/src/color_extentions.dart';
// import '../../../../core/di/injection.dart';
//
// class HomeVoiceChatWidget extends StatefulWidget {
//   const HomeVoiceChatWidget({super.key});
//
//   @override
//   State<HomeVoiceChatWidget> createState() => _HomeVoiceChatWidgetState();
// }
//
// class _HomeVoiceChatWidgetState extends State<HomeVoiceChatWidget>
//     with SingleTickerProviderStateMixin {
//   // ===========================================================================
//   // CONTROLLERS
//   // ===========================================================================
//
//   late final stt.SpeechToText _speech;
//
//   late final AudioPlayer _audioPlayer;
//
//   late final ChatBloc _chatBloc;
//
//   late final AnimationController _recordingAnimationController;
//
//   // ===========================================================================
//   // SUBSCRIPTIONS
//   // ===========================================================================
//
//   late final StreamSubscription<PlayerState> _audioSubscription;
//
//   // ===========================================================================
//   // REACTIVE UI STATE
//   // ===========================================================================
//
//   late final ValueNotifier<bool> _voiceChatActiveNotifier;
//
//   late final ValueNotifier<bool> _isSendingVoiceNotifier;
//
//   late final ValueNotifier<bool> _userHasSpokenNotifier;
//
//   late final ValueNotifier<double> _soundLevelNotifier;
//
//   late final ValueNotifier<String> _speechTextNotifier;
//
//   // ===========================================================================
//   // INTERNAL SPEECH STATE
//   // ===========================================================================
//
//   bool _speechInitialized = false;
//
//   bool _isStartingSpeech = false;
//
//   bool _speechSessionActive = false;
//
//   bool _restartScheduled = false;
//
//   bool _recordingRequested = false;
//
//   // ===========================================================================
//   // INTERNAL AUDIO STATE
//   // ===========================================================================
//
//   bool _aiAudioActuallyPlaying = false;
//
//   // ===========================================================================
//   // SPEECH TEXT
//   // ===========================================================================
//
//   String _lastRecognizedText = '';
//
//   String _speechTextBeforeCurrentSession = '';
//
//   // ===========================================================================
//   // TIMERS
//   // ===========================================================================
//
//   Timer? _silenceTimer;
//
//   // ===========================================================================
//   // SPEECH INFO
//   // ===========================================================================
//
//   DateTime? _lastUserSpeechAt;
//
//   // ===========================================================================
//   // CONFIG
//   // ===========================================================================
//
//   static const Duration _submitSilenceDuration = Duration(seconds: 2);
//
//   static const Duration _speechPauseDuration = Duration(minutes: 30);
//
//   static const Duration _speechListenDuration = Duration(minutes: 30);
//
//   // ===========================================================================
//   // SESSION
//   // ===========================================================================
//
//   int _recordingSessionId = 0;
//
//   // ===========================================================================
//   // GETTERS
//   // ===========================================================================
//
//   bool get _voiceChatActive => _voiceChatActiveNotifier.value;
//
//   set _voiceChatActive(bool value) {
//     _voiceChatActiveNotifier.value = value;
//   }
//
//   bool get _isSendingVoice => _isSendingVoiceNotifier.value;
//
//   set _isSendingVoice(bool value) {
//     _isSendingVoiceNotifier.value = value;
//   }
//
//   bool get _userHasSpoken => _userHasSpokenNotifier.value;
//
//   set _userHasSpoken(bool value) {
//     _userHasSpokenNotifier.value = value;
//   }
//
//   double get _soundLevel => _soundLevelNotifier.value;
//
//   set _soundLevel(double value) {
//     _soundLevelNotifier.value = value;
//   }
//
//   String get _speechText => _speechTextNotifier.value;
//
//   set _speechText(String value) {
//     _speechTextNotifier.value = value;
//   }
//
//   // ===========================================================================
//   // INIT STATE
//   // ===========================================================================
//
//   @override
//   void initState() {
//     super.initState();
//
//     // -------------------------------------------------------------------------
//     // CONTROLLERS
//     // -------------------------------------------------------------------------
//
//     _speech = stt.SpeechToText();
//
//     _audioPlayer = AudioPlayer();
//
//     _chatBloc = getIt<ChatBloc>();
//
//     _recordingAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//       lowerBound: 0,
//       upperBound: 1,
//     );
//
//     // -------------------------------------------------------------------------
//     // VALUE NOTIFIERS
//     // -------------------------------------------------------------------------
//
//     _voiceChatActiveNotifier = ValueNotifier<bool>(false);
//
//     _isSendingVoiceNotifier = ValueNotifier<bool>(false);
//
//     _userHasSpokenNotifier = ValueNotifier<bool>(false);
//
//     _soundLevelNotifier = ValueNotifier<double>(0);
//
//     _speechTextNotifier = ValueNotifier<String>('');
//
//     // -------------------------------------------------------------------------
//     // INITIALIZATION
//     // -------------------------------------------------------------------------
//
//     _initializeAudio();
//
//     unawaited(_initializeSpeech());
//   }
//
//   // ===========================================================================
//   // SPEECH INITIALIZE
//   // ===========================================================================
//
//   Future<void> _initializeSpeech() async {
//     try {
//       final available = await _speech.initialize(
//         onStatus: _onSpeechStatus,
//         onError: _onSpeechError,
//       );
//
//       if (!mounted) {
//         return;
//       }
//
//       _speechInitialized = available;
//     } catch (_) {
//       _speechInitialized = false;
//     }
//   }
//
//   // ===========================================================================
//   // AUDIO INITIALIZE
//   // ===========================================================================
//
//   void _initializeAudio() {
//     _audioSubscription = _audioPlayer.playerStateStream.listen((playerState) {
//       if (!mounted) {
//         return;
//       }
//
//       final processingState = playerState.processingState;
//       final playing = playerState.playing;
//
//       // ---------------------------------------------------------------------
//       // AUDIO COMPLETED
//       // ---------------------------------------------------------------------
//
//       if (processingState == ProcessingState.completed) {
//         if (!_aiAudioActuallyPlaying) {
//           return;
//         }
//
//         _aiAudioActuallyPlaying = false;
//
//         unawaited(_onAiAudioCompleted());
//
//         return;
//       }
//
//       // ---------------------------------------------------------------------
//       // AUDIO STARTED
//       // ---------------------------------------------------------------------
//
//       if (playing && !_aiAudioActuallyPlaying) {
//         _aiAudioActuallyPlaying = true;
//       }
//     });
//   }
//
//   // ===========================================================================
//   // SESSION
//   // ===========================================================================
//
//   void _invalidateRecordingSession() {
//     _recordingSessionId++;
//
//     _recordingRequested = false;
//
//     _speechSessionActive = false;
//
//     _isStartingSpeech = false;
//
//     _restartScheduled = false;
//   }
//
//   // ===========================================================================
//   // OPEN VOICE CHAT
//   // ===========================================================================
//
//   void _openVoiceChat() {
//     if (!mounted) {
//       return;
//     }
//
//     HapticFeedback.lightImpact();
//
//     _voiceChatActive = true;
//
//     _isSendingVoice = false;
//
//     _recordingRequested = true;
//
//     _userHasSpoken = false;
//
//     _speechText = '';
//
//     _lastRecognizedText = '';
//
//     _speechTextBeforeCurrentSession = '';
//
//     _chatBloc.add(SentListenEvent());
//
//     unawaited(_startRecording());
//   }
//
//   // ===========================================================================
//   // CLOSE VOICE CHAT
//   // ===========================================================================
//
//   Future<void> _closeVoiceChat() async {
//     if (!mounted) {
//       return;
//     }
//
//     HapticFeedback.lightImpact();
//
//     _voiceChatActive = false;
//
//     _invalidateRecordingSession();
//
//     _cancelTimers();
//
//     // -------------------------------------------------------------------------
//     // STOP SPEECH
//     // -------------------------------------------------------------------------
//
//     try {
//       if (_speech.isListening) {
//         await _speech.cancel();
//       }
//     } catch (_) {}
//
//     // -------------------------------------------------------------------------
//     // STOP AI AUDIO
//     // -------------------------------------------------------------------------
//
//     try {
//       _aiAudioActuallyPlaying = false;
//
//       await _audioPlayer.stop();
//     } catch (_) {}
//
//     // -------------------------------------------------------------------------
//     // CLEAR STATE
//     // -------------------------------------------------------------------------
//
//     _clearLocalData();
//
//     _chatBloc.add(ResetVoiceEvent());
//
//     _chatBloc.add(SentDisableEvent());
//   }
//
//   // ===========================================================================
//   // CANCEL TIMERS
//   // ===========================================================================
//
//   void _cancelTimers() {
//     _silenceTimer?.cancel();
//
//     _silenceTimer = null;
//
//     _restartScheduled = false;
//   }
//
//   // ===========================================================================
//   // CLEAR LOCAL DATA
//   // ===========================================================================
//
//   void _clearLocalData() {
//     _speechText = '';
//
//     _lastRecognizedText = '';
//
//     _speechTextBeforeCurrentSession = '';
//
//     _soundLevel = 0;
//
//     _userHasSpoken = false;
//
//     _isStartingSpeech = false;
//
//     _isSendingVoice = false;
//
//     _speechSessionActive = false;
//
//     _cancelTimers();
//
//     _recordingAnimationController.stop();
//
//     _recordingAnimationController.value = 0;
//
//     _aiAudioActuallyPlaying = false;
//   }
//
//   // ===========================================================================
//   // WAIT FOR SPEECH TO FINISH
//   // ===========================================================================
//
//   Future<void> _waitForSpeechToFinish() async {
//     try {
//       if (_speech.isListening) {
//         await _speech.cancel();
//       }
//     } catch (_) {}
//
//     for (int i = 0; i < 20; i++) {
//       if (!mounted) {
//         return;
//       }
//
//       if (!_speech.isListening) {
//         break;
//       }
//
//       await Future<void>.delayed(const Duration(milliseconds: 100));
//     }
//
//     await Future<void>.delayed(const Duration(milliseconds: 250));
//   }
//
//   // ===========================================================================
//   // START RECORDING
//   // ===========================================================================
//
//   Future<void> _startRecording({bool force = false}) async {
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     if (_isSendingVoice) {
//       return;
//     }
//
//     if (_speechSessionActive && !force) {
//       return;
//     }
//
//     if (_isStartingSpeech) {
//       return;
//     }
//
//     final sessionId = ++_recordingSessionId;
//
//     _isStartingSpeech = true;
//
//     _recordingRequested = true;
//
//     _speechSessionActive = false;
//
//     _speechTextBeforeCurrentSession = _speechText.trim();
//
//     _lastRecognizedText = '';
//
//     try {
//       // -----------------------------------------------------------------------
//       // MICROPHONE PERMISSION
//       // -----------------------------------------------------------------------
//
//       final permission = await Permission.microphone.request();
//
//       if (!mounted || sessionId != _recordingSessionId) {
//         return;
//       }
//
//       if (!permission.isGranted) {
//         _recordingRequested = false;
//
//         _speechSessionActive = false;
//
//         _chatBloc.add(SentFailedEvent());
//
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // WAIT FOR PREVIOUS SESSION
//       // -----------------------------------------------------------------------
//
//       await _waitForSpeechToFinish();
//
//       if (!mounted || sessionId != _recordingSessionId) {
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // INITIALIZE SPEECH IF NEEDED
//       // -----------------------------------------------------------------------
//
//       if (!_speechInitialized) {
//         final available = await _speech.initialize(
//           onStatus: _onSpeechStatus,
//           onError: _onSpeechError,
//         );
//
//         if (!mounted || sessionId != _recordingSessionId) {
//           return;
//         }
//
//         if (!available) {
//           _recordingRequested = false;
//
//           _speechSessionActive = false;
//
//           _chatBloc.add(SentFailedEvent());
//
//           return;
//         }
//
//         _speechInitialized = true;
//       }
//
//       // -----------------------------------------------------------------------
//       // ENSURE LISTENING STATE
//       // -----------------------------------------------------------------------
//
//       if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
//         _chatBloc.add(SentListenEvent());
//
//         await Future<void>.delayed(const Duration(milliseconds: 50));
//       }
//
//       if (!mounted || sessionId != _recordingSessionId) {
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // START STT
//       // -----------------------------------------------------------------------
//
//       _speechSessionActive = true;
//
//       await _speech.listen(
//         listenOptions: stt.SpeechListenOptions(
//           localeId: Localizations.localeOf(context).toString(),
//           listenFor: _speechListenDuration,
//           pauseFor: _speechPauseDuration,
//           partialResults: true,
//           cancelOnError: false,
//           listenMode: stt.ListenMode.dictation,
//         ),
//         onSoundLevelChange: _onSoundLevelChange,
//         onResult: _onSpeechResult,
//       );
//
//       if (!mounted || sessionId != _recordingSessionId) {
//         return;
//       }
//
//       _speechSessionActive = true;
//     } catch (_) {
//       if (!mounted || sessionId != _recordingSessionId) {
//         return;
//       }
//
//       _speechSessionActive = false;
//     } finally {
//       _isStartingSpeech = false;
//     }
//   }
//
//   // ===========================================================================
//   // SPEECH STATUS
//   // ===========================================================================
//
//   void _onSpeechStatus(String status) {
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     if (status == 'listening') {
//       _speechSessionActive = true;
//
//       return;
//     }
//
//     if (status == 'done' || status == 'notListening') {
//       _speechSessionActive = false;
//     }
//   }
//
//   // ===========================================================================
//   // SPEECH ERROR
//   // ===========================================================================
//
//   void _onSpeechError(dynamic error) {
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     _speechSessionActive = false;
//
//     final errorText = error.toString();
//
//     if (errorText.contains('error_busy')) {
//       return;
//     }
//
//     if (_recordingRequested && !_isSendingVoice) {
//       return;
//     }
//
//     _chatBloc.add(SentFailedEvent());
//   }
//
//   // ===========================================================================
//   // SOUND LEVEL
//   // ===========================================================================
//
//   void _onSoundLevelChange(double level) {
//     if (!mounted || !_voiceChatActive || _isSendingVoice) {
//       return;
//     }
//
//     if (!_speechSessionActive) {
//       return;
//     }
//
//     if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
//       return;
//     }
//
//     _soundLevel = level;
//   }
//
//   // ===========================================================================
//   // MERGE SPEECH TEXT
//   // ===========================================================================
//
//   String _mergeSpeechText(String recognizedText) {
//     final current = recognizedText.trim();
//
//     if (current.isEmpty) {
//       return _speechTextBeforeCurrentSession;
//     }
//
//     final base = _speechTextBeforeCurrentSession.trim();
//
//     if (base.isEmpty) {
//       return current;
//     }
//
//     if (current.startsWith(base)) {
//       return current;
//     }
//
//     if (base == current) {
//       return base;
//     }
//
//     return '$base $current'.trim();
//   }
//
//   // ===========================================================================
//   // SPEECH RESULT
//   // ===========================================================================
//
//   void _onSpeechResult(dynamic result) {
//     if (!mounted) {
//       return;
//     }
//
//     final current = result.recognizedWords.trim();
//
//     if (!_voiceChatActive || current.isEmpty) {
//       return;
//     }
//
//     if (!_speechSessionActive && !_speech.isListening) {
//       return;
//     }
//
//     if (_chatBloc.state.voiceChatState != VoiceChatState.listening) {
//       return;
//     }
//
//     final mergedText = _mergeSpeechText(current);
//
//     if (mergedText == _lastRecognizedText) {
//       return;
//     }
//
//     _lastRecognizedText = mergedText;
//
//     _speechText = mergedText;
//
//     _userHasSpoken = true;
//
//     _lastUserSpeechAt = DateTime.now();
//
//     try {
//       _speech.changePauseFor(_speechPauseDuration);
//     } catch (_) {}
//
//     _startSilenceTimer();
//   }
//
//   // ===========================================================================
//   // SILENCE TIMER
//   // ===========================================================================
//
//   void _startSilenceTimer() {
//     _silenceTimer?.cancel();
//
//     if (!_userHasSpoken) {
//       return;
//     }
//
//     final session = _recordingSessionId;
//
//     _silenceTimer = Timer(_submitSilenceDuration, () async {
//       if (!mounted || !_voiceChatActive || _isSendingVoice || !_userHasSpoken) {
//         return;
//       }
//
//       if (session != _recordingSessionId) {
//         return;
//       }
//
//       final lastSpeech = _lastUserSpeechAt;
//
//       if (lastSpeech != null) {
//         final elapsed = DateTime.now().difference(lastSpeech);
//
//         if (elapsed < _submitSilenceDuration) {
//           _startSilenceTimer();
//
//           return;
//         }
//       }
//
//       final message = _speechText.trim();
//
//       if (message.isEmpty) {
//         return;
//       }
//
//       await _finishUserSpeechAndSend(message);
//     });
//   }
//
//   // ===========================================================================
//   // FINISH USER SPEECH
//   // ===========================================================================
//
//   Future<void> _finishUserSpeechAndSend(String message) async {
//     if (!mounted || _isSendingVoice) {
//       return;
//     }
//
//     final text = message.trim();
//
//     if (text.isEmpty) {
//       return;
//     }
//
//     _silenceTimer?.cancel();
//
//     _silenceTimer = null;
//
//     _recordingRequested = false;
//
//     _speechSessionActive = false;
//
//     _userHasSpoken = false;
//
//     try {
//       if (_speech.isListening) {
//         await _speech.stop();
//       }
//     } catch (_) {}
//
//     if (!mounted) {
//       return;
//     }
//
//     await _sendVoiceMessage(text);
//   }
//
//   // ===========================================================================
//   // SEND VOICE MESSAGE
//   // ===========================================================================
//
//   Future<void> _sendVoiceMessage(String message) async {
//     if (!mounted) {
//       return;
//     }
//
//     final text = message.trim();
//
//     if (text.isEmpty || _isSendingVoice) {
//       return;
//     }
//
//     _isSendingVoice = true;
//
//     _recordingRequested = false;
//
//     _speechSessionActive = false;
//
//     _userHasSpoken = false;
//
//     _speechText = '';
//
//     _lastRecognizedText = '';
//
//     _speechTextBeforeCurrentSession = '';
//
//     _soundLevel = 0;
//
//     _chatBloc.add(SentLoadingEvent());
//
//     _chatBloc.add(SendVoiceEvent(params: SendVoiceParams(message: text)));
//   }
//
//   // ===========================================================================
//   // PLAY AI AUDIO
//   // ===========================================================================
//
//   Future<void> _playAiAudio(String answer) async {
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     try {
//       final url = _extractAudioUrl(answer);
//
//       // -----------------------------------------------------------------------
//       // NO AUDIO URL
//       // -----------------------------------------------------------------------
//
//       if (url == null || url.isEmpty) {
//         _isSendingVoice = false;
//
//         _recordingRequested = true;
//
//         _chatBloc.add(SentListenEvent());
//
//         await _startRecording(force: true);
//
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // INVALIDATE USER SESSION
//       // -----------------------------------------------------------------------
//
//       _aiAudioActuallyPlaying = false;
//
//       _recordingRequested = false;
//
//       _speechSessionActive = false;
//
//       _isStartingSpeech = false;
//
//       _restartScheduled = false;
//
//       _recordingSessionId++;
//
//       // -----------------------------------------------------------------------
//       // STOP STT
//       // -----------------------------------------------------------------------
//
//       try {
//         if (_speech.isListening) {
//           await _speech.cancel();
//         }
//       } catch (_) {}
//
//       await _waitForSpeechToFinish();
//
//       if (!mounted || !_voiceChatActive) {
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // STOP PREVIOUS AUDIO
//       // -----------------------------------------------------------------------
//
//       try {
//         await _audioPlayer.stop();
//       } catch (_) {}
//
//       if (!mounted || !_voiceChatActive) {
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // LOAD AUDIO
//       // -----------------------------------------------------------------------
//
//       await _audioPlayer.setUrl(url);
//
//       if (!mounted || !_voiceChatActive) {
//         return;
//       }
//
//       // -----------------------------------------------------------------------
//       // PLAY
//       // -----------------------------------------------------------------------
//
//       await _audioPlayer.play();
//     } catch (_) {
//       if (!mounted) {
//         return;
//       }
//
//       _aiAudioActuallyPlaying = false;
//
//       _isSendingVoice = false;
//
//       _recordingRequested = true;
//
//       _chatBloc.add(SentListenEvent());
//
//       await _startRecording(force: true);
//     }
//   }
//
//   // ===========================================================================
//   // STOP AI AUDIO
//   // ===========================================================================
//
//   Future<void> _stopAiAudio() async {
//     if (!mounted) {
//       return;
//     }
//
//     // -------------------------------------------------------------------------
//     // INVALIDATE AI SESSION
//     // -------------------------------------------------------------------------
//
//     _aiAudioActuallyPlaying = false;
//
//     _recordingRequested = false;
//
//     _speechSessionActive = false;
//
//     _isStartingSpeech = false;
//
//     _restartScheduled = false;
//
//     _recordingSessionId++;
//
//     // -------------------------------------------------------------------------
//     // STOP AUDIO
//     // -------------------------------------------------------------------------
//
//     try {
//       await _audioPlayer.stop();
//     } catch (_) {}
//
//     // -------------------------------------------------------------------------
//     // STOP OLD STT
//     // -------------------------------------------------------------------------
//
//     try {
//       if (_speech.isListening) {
//         await _speech.cancel();
//       }
//     } catch (_) {}
//
//     await _waitForSpeechToFinish();
//
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     // -------------------------------------------------------------------------
//     // RESET USER SESSION
//     // -------------------------------------------------------------------------
//
//     _isSendingVoice = false;
//
//     _userHasSpoken = false;
//
//     _speechText = '';
//
//     _lastRecognizedText = '';
//
//     _speechTextBeforeCurrentSession = '';
//
//     _soundLevel = 0;
//
//     // -------------------------------------------------------------------------
//     // GO TO LISTENING
//     // -------------------------------------------------------------------------
//
//     _chatBloc.add(SentListenEvent());
//
//     _recordingRequested = true;
//
//     await _startRecording(force: true);
//   }
//
//   // ===========================================================================
//   // AI AUDIO COMPLETED
//   // ===========================================================================
//
//   Future<void> _onAiAudioCompleted() async {
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     // -------------------------------------------------------------------------
//     // INVALIDATE AI STATE
//     // -------------------------------------------------------------------------
//
//     _aiAudioActuallyPlaying = false;
//
//     _isSendingVoice = false;
//
//     _recordingRequested = true;
//
//     _speechSessionActive = false;
//
//     _isStartingSpeech = false;
//
//     _restartScheduled = false;
//
//     // -------------------------------------------------------------------------
//     // RESET USER SESSION
//     // -------------------------------------------------------------------------
//
//     _userHasSpoken = false;
//
//     _speechText = '';
//
//     _lastRecognizedText = '';
//
//     _speechTextBeforeCurrentSession = '';
//
//     _soundLevel = 0;
//
//     _recordingSessionId++;
//
//     // -------------------------------------------------------------------------
//     // CLOSE OLD STT
//     // -------------------------------------------------------------------------
//
//     await _waitForSpeechToFinish();
//
//     if (!mounted || !_voiceChatActive) {
//       return;
//     }
//
//     // -------------------------------------------------------------------------
//     // LISTENING
//     // -------------------------------------------------------------------------
//
//     _chatBloc.add(SentListenEvent());
//
//     await _startRecording(force: true);
//   }
//
//   // ===========================================================================
//   // AUDIO URL
//   // ===========================================================================
//
//   String? _extractAudioUrl(String value) {
//     final text = value.trim();
//
//     if (text.isEmpty) {
//       return null;
//     }
//
//     // -------------------------------------------------------------------------
//     // MARKDOWN URL
//     // -------------------------------------------------------------------------
//
//     final markdownMatch = RegExp(r'\]\((https?:\/\/[^)]+)\)').firstMatch(text);
//
//     if (markdownMatch != null) {
//       return markdownMatch.group(1);
//     }
//
//     // -------------------------------------------------------------------------
//     // PLAIN URL
//     // -------------------------------------------------------------------------
//
//     final urlMatch = RegExp(r'https?:\/\/[^\s]+').firstMatch(text);
//
//     return urlMatch?.group(0);
//   }
//
//   // ===========================================================================
//   // BUILD
//   // ===========================================================================
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ChatBloc, ChatState>(
//       bloc: _chatBloc,
//       listenWhen: (previous, current) {
//         return previous.voiceChatState != VoiceChatState.aiSpeaking &&
//             current.voiceChatState == VoiceChatState.aiSpeaking;
//       },
//       listener: (context, state) {
//         final answer = state.voiceData.data?.data?.answer;
//
//         // ---------------------------------------------------------------------
//         // NO ANSWER
//         // ---------------------------------------------------------------------
//
//         if (answer == null || answer.trim().isEmpty) {
//           _isSendingVoice = false;
//
//           _recordingRequested = true;
//
//           _chatBloc.add(SentListenEvent());
//
//           unawaited(_startRecording(force: true));
//
//           return;
//         }
//
//         // ---------------------------------------------------------------------
//         // PLAY AI
//         // ---------------------------------------------------------------------
//
//         unawaited(_playAiAudio(answer.trim()));
//       },
//       child: BlocBuilder<ChatBloc, ChatState>(
//         bloc: _chatBloc,
//         builder: (context, state) {
//           return _buildMainContainer(state);
//         },
//       ),
//     );
//   }
//
//   // ===========================================================================
//   // MAIN CONTAINER
//   // ===========================================================================
//
//   Widget _buildMainContainer(ChatState state) {
//     final isDisable = state.voiceChatState == VoiceChatState.disable;
//
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 280),
//       curve: Curves.easeOut,
//       padding: EdgeInsets.symmetric(
//         horizontal:isDisable?16: 14,
//         vertical: isDisable ? 16 : 10,
//       ),
//       decoration: BoxDecoration(
//         color: isDisable ? context.primarySwatch : null,
//         gradient: LinearGradient(
//           colors: [context.primarySwatch.derivedColor, context.primarySwatch, context.primarySwatch],
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//         ),
//         borderRadius: BorderRadius.circular(5000),
//         boxShadow: [
//           BoxShadow(
//             color: context.primarySwatch.withValues(alpha: 0.25),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 280),
//         switchInCurve: Curves.easeOut,
//         switchOutCurve: Curves.easeIn,
//         child: _buildStateContent(state),
//       ),
//     );
//   }
//
//   // ===========================================================================
//   // STATE CONTENT
//   // ===========================================================================
//
//   Widget _buildStateContent(ChatState state) {
//     switch (state.voiceChatState) {
//       case VoiceChatState.disable:
//         return VoiceDisableContent(onTap: _openVoiceChat);
//
//       case VoiceChatState.listening:
//         return VoiceListeningContent(
//           onClose: _closeVoiceChat,
//           animation: _recordingAnimationController,
//         );
//
//       case VoiceChatState.loading:
//         return VoiceLoadingContent(onClose: _closeVoiceChat);
//
//       case VoiceChatState.aiSpeaking:
//         return VoiceAiSpeakingContent(
//           onStop: _stopAiAudio,
//           onClose: _closeVoiceChat,
//         );
//
//       case VoiceChatState.failed:
//         return VoiceFailedContent(
//           onRetry: _retryVoiceChat,
//           onClose: _closeVoiceChat,
//         );
//     }
//   }
//
//   // ===========================================================================
//   // RETRY
//   // ===========================================================================
//
//   void _retryVoiceChat() {
//     if (!mounted) {
//       return;
//     }
//
//     HapticFeedback.lightImpact();
//
//     _isSendingVoice = false;
//
//     _recordingRequested = true;
//
//     _voiceChatActive = true;
//
//     _speechText = '';
//
//     _speechTextBeforeCurrentSession = '';
//
//     _lastRecognizedText = '';
//
//     _chatBloc.add(SentListenEvent());
//
//     unawaited(_startRecording(force: true));
//   }
//
//   // ===========================================================================
//   // DISPOSE
//   // ===========================================================================
//
//   @override
//   void dispose() {
//     _voiceChatActive = false;
//
//     _recordingRequested = false;
//
//     _speechSessionActive = false;
//
//     _recordingSessionId++;
//
//     _aiAudioActuallyPlaying = false;
//
//     _isStartingSpeech = false;
//
//     _cancelTimers();
//
//     // -------------------------------------------------------------------------
//     // SPEECH
//     // -------------------------------------------------------------------------
//
//     try {
//       _speech.cancel();
//     } catch (_) {}
//
//     // -------------------------------------------------------------------------
//     // AUDIO
//     // -------------------------------------------------------------------------
//
//     _audioSubscription.cancel();
//
//     _audioPlayer.dispose();
//
//     // -------------------------------------------------------------------------
//     // ANIMATION
//     // -------------------------------------------------------------------------
//
//     _recordingAnimationController.dispose();
//
//     // -------------------------------------------------------------------------
//     // VALUE NOTIFIERS
//     // -------------------------------------------------------------------------
//
//     _voiceChatActiveNotifier.dispose();
//
//     _isSendingVoiceNotifier.dispose();
//
//     _userHasSpokenNotifier.dispose();
//
//     _soundLevelNotifier.dispose();
//
//     _speechTextNotifier.dispose();
//
//     super.dispose();
//   }
// }
import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
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

import '../../../../common/extensions/src/color_extentions.dart';
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

  late final stt.SpeechToText _speech;

  late final AudioPlayer _audioPlayer;

  late final ChatBloc _chatBloc;

  late final AnimationController _recordingAnimationController;

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

  bool _intentionalSpeechStop = false;

  // ===========================================================================
  // INTERNAL AUDIO STATE
  // ===========================================================================

  bool _aiAudioActuallyPlaying = false;

  bool _aiInterruptedByUser = false;

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

  static const Duration _backgroundRestartDelay = Duration(milliseconds: 220);

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
    final session = await AudioSession.instance;

    await session.configure(
      const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions:
            AVAudioSessionCategoryOptions.allowBluetooth |
                AVAudioSessionCategoryOptions.defaultToSpeaker |
                AVAudioSessionCategoryOptions.mixWithOthers,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType:
            AndroidAudioFocusGainType.gainTransientMayDuck,
      ),
    );

    await session.setActive(true);

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

    _intentionalSpeechStop = false;
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

    _aiInterruptedByUser = false;

  }

  // ===========================================================================
  // WAIT FOR SPEECH TO FINISH
  // ===========================================================================

  Future<void> _waitForSpeechToFinish() async {
    try {
      if (_speech.isListening) {
        _intentionalSpeechStop = true;
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

    _intentionalSpeechStop = false;
  }

  // ===========================================================================
  // START RECORDING
  // ===========================================================================

  Future<void> _startRecording({
    bool force = false,
    bool backgroundForAi = false,
  }) async {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    if (_isSendingVoice && !backgroundForAi) {
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

    _recordingRequested = !backgroundForAi;

    _speechSessionActive = false;

    _speechTextBeforeCurrentSession = _speechText.trim();

    _lastRecognizedText = '';

    try {
      // -----------------------------------------------------------------------
      // MICROPHONE PERMISSION
      // -----------------------------------------------------------------------

      final permission = backgroundForAi
          ? await Permission.microphone.status
          : await Permission.microphone.request();

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      if (!permission.isGranted) {
        _recordingRequested = false;

        _speechSessionActive = false;

        if (!backgroundForAi) {
          _chatBloc.add(SentFailedEvent());
        }

        return;
      }

      // -----------------------------------------------------------------------
      // WAIT FOR PREVIOUS SESSION
      // -----------------------------------------------------------------------

      await _waitForSpeechToFinish();

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

          if (!backgroundForAi) {
            _chatBloc.add(SentFailedEvent());
          }

          return;
        }

        _speechInitialized = true;
      }

      // -----------------------------------------------------------------------
      // ENSURE FOREGROUND LISTENING STATE
      // -----------------------------------------------------------------------

      if (!backgroundForAi &&
          _chatBloc.state.voiceChatState != VoiceChatState.listening) {
        _chatBloc.add(SentListenEvent());

        await Future<void>.delayed(const Duration(milliseconds: 50));
      }

      if (!mounted || sessionId != _recordingSessionId) {
        return;
      }

      // -----------------------------------------------------------------------
      // START STT
      // -----------------------------------------------------------------------

      // During aiSpeaking this STT session is deliberately silent and invisible:
      // it exists only to catch the first user word for barge-in. Timeouts from
      // this session are handled by _onSpeechStatus/_onSpeechError and restarted
      // without touching Bloc state, so the UI never blinks or enters failed.

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

      if (backgroundForAi && _isAiBackgroundListeningAllowed) {
        _scheduleAiBackgroundListeningRestart();
      } else if (!backgroundForAi && _recordingRequested && !_isSendingVoice) {
        _chatBloc.add(SentFailedEvent());
      }
    } finally {
      _isStartingSpeech = false;
    }
  }

  // ===========================================================================
  // START LISTENING FOR INTERRUPTION (DURING AI SPEAKING)
  // ===========================================================================

  Future<void> _startListeningForInterruption() async {
    if (!_isAiBackgroundListeningAllowed) {
      return;
    }

    await _startRecording(force: true, backgroundForAi: true);
  }

  bool get _isAiBackgroundListeningAllowed {
    return mounted &&
        _voiceChatActive &&
        !_aiInterruptedByUser &&
        _chatBloc.state.voiceChatState == VoiceChatState.aiSpeaking;
  }

  void _scheduleAiBackgroundListeningRestart() {
    if (_restartScheduled || !_isAiBackgroundListeningAllowed) {
      return;
    }

    _restartScheduled = true;

    Timer(_backgroundRestartDelay, () {
      _restartScheduled = false;

      if (!_isAiBackgroundListeningAllowed || _isStartingSpeech) {
        return;
      }

      unawaited(_startListeningForInterruption());
    });
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

      // Background STT sessions commonly end with done/notListening even when
      // nothing is wrong. While AI audio is speaking, that is not a user-visible
      // failure; immediately cycle the recognizer so interruption remains armed.
      if (!_intentionalSpeechStop && _isAiBackgroundListeningAllowed) {
        _scheduleAiBackgroundListeningRestart();
      }
    }
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
      if (_isAiBackgroundListeningAllowed) {
        _scheduleAiBackgroundListeningRestart();
      }
      return;
    }

    if (_isAiBackgroundListeningAllowed) {
      _scheduleAiBackgroundListeningRestart();
      return;
    }

    if (_recordingRequested && !_isSendingVoice) {
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

    // -------------------------------------------------------------------------
    // INTERRUPTION DETECTED: USER SPOKE WHILE AI WAS SPEAKING
    // -------------------------------------------------------------------------

    if (_chatBloc.state.voiceChatState == VoiceChatState.aiSpeaking) {
      unawaited(_handleAiInterruption(current));
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
  // HANDLE AI INTERRUPTION
  // ===========================================================================

  Future<void> _handleAiInterruption(String recognizedText) async {
    if (!mounted || !_voiceChatActive) {
      return;
    }

    // 1. Stop AI audio immediately. The stop Future is intentionally not
    // awaited before SentListenEvent, because barge-in must feel instant even if
    // the platform audio session takes a few frames to fully release.
    _aiInterruptedByUser = true;

    _aiAudioActuallyPlaying = false;
    unawaited(_audioPlayer.stop().catchError((_) {}));

    // 2. Switch Bloc state to listening
    _chatBloc.add(SentListenEvent());

    // 3. Update internal user speech state
    _isSendingVoice = false;
    _userHasSpoken = true;
    _lastRecognizedText = recognizedText;
    _speechText = recognizedText;
    _lastUserSpeechAt = DateTime.now();

    _speechSessionActive = _speech.isListening;

    _recordingRequested = true;

    _speechTextBeforeCurrentSession = recognizedText;

    // 4. Start silence timer to send user message when done talking
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
        _intentionalSpeechStop = true;
        await _speech.stop();
      }
    } catch (_) {}

    _intentionalSpeechStop = false;

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

      _aiInterruptedByUser = false;

      _recordingRequested = false;

      _speechSessionActive = false;

      _isStartingSpeech = false;

      _restartScheduled = false;

      _recordingSessionId++;

      // -----------------------------------------------------------------------
      // STOP PREVIOUS STT & WAIT
      // -----------------------------------------------------------------------

      try {
        if (_speech.isListening) {
          _intentionalSpeechStop = true;
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
      // PLAY AI AUDIO & START LISTENING FOR INTERRUPTION
      // -----------------------------------------------------------------------

      final session = await AudioSession.instance;
      await session.setActive(true);

      unawaited(_audioPlayer.play());

      // Keep STT alive while AI audio plays. This is intentionally decoupled
      // from UI state: the Bloc remains aiSpeaking unless _onSpeechResult sees
      // actual words, at which point _handleAiInterruption stops audio and moves
      // to listening.
      await _startListeningForInterruption();
    } catch (_) {
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

    _aiInterruptedByUser = false;

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
        _intentionalSpeechStop = true;
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

    _aiInterruptedByUser = false;

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
    return BlocListener<ChatBloc, ChatState>(
      bloc: _chatBloc,
      listenWhen: (previous, current) {
        return previous.voiceChatState != VoiceChatState.aiSpeaking &&
            current.voiceChatState == VoiceChatState.aiSpeaking;
      },
      listener: (context, state) {
        final answer = state.voiceData.data?.data?.answer;

        // ---------------------------------------------------------------------
        // NO ANSWER
        // ---------------------------------------------------------------------

        if (answer == null || answer.trim().isEmpty) {
          _isSendingVoice = false;

          _recordingRequested = true;

          _chatBloc.add(SentListenEvent());

          unawaited(_startRecording(force: true));

          return;
        }

        // ---------------------------------------------------------------------
        // PLAY AI
        // ---------------------------------------------------------------------

        unawaited(_playAiAudio(answer.trim()));
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
      padding: EdgeInsets.symmetric(
        horizontal: isDisable ? 16 : 14,
        vertical: isDisable ? 16 : 10,
      ),
      decoration: BoxDecoration(
        color: isDisable ? context.primarySwatch : null,
        gradient: LinearGradient(
          colors: [
            context.primarySwatch.derivedColor,
            context.primarySwatch,
            context.primarySwatch
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

    _aiInterruptedByUser = false;

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

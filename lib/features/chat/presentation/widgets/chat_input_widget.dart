import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/design/src/theme/toaster.dart';
import '../../../../common/design/src/widgets/app_text_field.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/extensions/src/validation.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../domin/use_cases/send_message_use_case.dart';
import '../bloc/chat_bloc.dart';

class ChatInputWidget extends StatefulWidget {
  final ChatBloc chatBloc;
  final GlobalKey<FormState> globalKey;

  const ChatInputWidget({
    super.key,
    required this.chatBloc,
    required this.globalKey,
  });

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget>
    with SingleTickerProviderStateMixin {
  late final TextEditingController controller1;

  late final ValueNotifier<bool> _hasText;

  final stt.SpeechToText _speech = stt.SpeechToText();

  late AnimationController _waveController;
  bool _isRecording = false;

  bool _isStartingSpeech = false;

  double _soundLevel = 0;

  String _speechBaseText = "";
  String _lastRecognizedText = "";

  @override
  void initState() {
    super.initState();

    controller1 = TextEditingController();

    _hasText = ValueNotifier(false);

    controller1.addListener(() {
      _hasText.value = controller1.text.trim().isNotEmpty;
    });

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();

      return;
    }

    if (_isStartingSpeech) return;

    _isStartingSpeech = true;

    try {
      final permission = await Permission.microphone.request();

      if (!permission.isGranted) return;

      await _speech.stop();

      final available = await _speech.initialize(
        onStatus: (status) {
          if (!mounted) return;

          if (status == "done" || status == "notListening") {
            setState(() {
              _isRecording = false;

              _soundLevel = 0;
            });
          }
        },

        onError: (error) {
          if (!mounted) return;

          setState(() {
            _isRecording = false;

            _soundLevel = 0;
          });
        },
      );

      if (!available) return;

      _speechBaseText = controller1.text.trim();

      _lastRecognizedText = "";

      setState(() {
        _isRecording = true;
      });

      await _speech.listen(
        listenOptions: stt.SpeechListenOptions(
          localeId: context.locale.toString(),

          listenFor: const Duration(minutes: 5),

          pauseFor: const Duration(seconds: 5),

          partialResults: true,
        ),

        onSoundLevelChange: (level) {
          if (!mounted) return;

          setState(() {
            _soundLevel = level;
          });
        },

        onResult: (result) {
          if (!mounted) return;

          final current = result.recognizedWords.trim();

          if (current.isEmpty) return;

          // منع تكرار نفس النتيجة

          if (current == _lastRecognizedText) {
            return;
          }

          _lastRecognizedText = current;

          String newText;

          if (_speechBaseText.isEmpty) {
            newText = current;
          } else if (current.startsWith(_speechBaseText)) {
            newText = current;
          } else {
            newText = "$_speechBaseText $current";
          }

          controller1.value = controller1.value.copyWith(
            text: newText,

            selection: TextSelection.collapsed(offset: newText.length),
          );
        },
      );
    } finally {
      _isStartingSpeech = false;
    }
  }

  Future<void> _restartListening() async {
    try {
      await _speech.listen(
        listenOptions: stt.SpeechListenOptions(
          localeId: context.locale.toString(),

          listenFor: const Duration(minutes: 5),

          pauseFor: const Duration(seconds: 5),

          partialResults: true,
        ),

        onSoundLevelChange: (level) {
          if (!mounted) return;

          setState(() {
            _soundLevel = level;
          });
        },

        onResult: (result) {
          if (!mounted) return;

          final current = result.recognizedWords.trim();

          if (current.isEmpty) return;

          final old = _speechBaseText.trim();

          String mergedText;

          // أول كلام

          if (old.isEmpty) {
            mergedText = current;
          }
          // المحرك رجع النص كامل
          else if (current.startsWith(old)) {
            mergedText = current;
          }
          // المحرك بدأ جلسة جديدة
          else {
            mergedText = "$old $current";
          }

          _speechBaseText = mergedText;

          setState(() {
            controller1.value = controller1.value.copyWith(
              text: mergedText,

              selection: TextSelection.collapsed(offset: mergedText.length),
            );
          });
        },
      );
    } catch (_) {}
  }

  Future<void> _stopRecording() async {
    try {
      await _speech.stop();
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _isRecording = false;

      _soundLevel = 0;
    });
  }

  Future<void> _sendMessage() async {
    if (_isRecording) {
      await _stopRecording();
    }

    final text = controller1.text.trim();

    if (text.isEmpty) return;

    widget.chatBloc.add(
      SendMessageEvent(params: SendMessageParams(message: text)),
    );

    controller1.clear();

    _speechBaseText = "";
    _lastRecognizedText = "";
  }

  @override
  void dispose() {
    if (_speech.isListening) {
      _speech.stop();
    }

    controller1.dispose();

    _hasText.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.globalKey,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            if (_isRecording) _buildRecordingWidget(),

            const SizedBox(height: 8),

            SizedBox(
              height: 56,

              child: Row(
                children: [
                  SizedBox(
                    width: 56,
                    height: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        if (controller1.text.trim().isNotEmpty) {
                          _sendMessage();
                        } else {
                          HapticFeedback.lightImpact();

                          _toggleRecording();
                        }
                      },

                      child: ValueListenableBuilder<bool>(
                        valueListenable: _hasText,

                        builder: (context, hasText, _) {
                          return Container(
                            decoration: BoxDecoration(
                              color: _isRecording
                                  ? Colors.redAccent
                                  : context.primarySwatch,

                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Transform(
                              alignment: Alignment.center,

                              transform: Matrix4.rotationY(math.pi),

                              child: Icon(
                                hasText
                                    ? Icons.send_outlined
                                    : _isRecording
                                    ? Icons.stop_rounded
                                    : Icons.mic_rounded,

                                color: Colors.white,

                                size: 30,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ChatTextFiled(
                      height: 56,

                      isPadding: false,

                      keyboardType: TextInputType.text,

                      hintText: LocaleKeys.chatNewMessage.tr(),

                      controller: controller1,

                      validator: (text) => text.isNameText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingWidget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.primarySwatch.derivedColor, context.primarySwatch],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 25),
          ),

          const SizedBox(width: 12),

          Flexible(
            flex: 2,
            child: Text(
              LocaleKeys.audioRecording.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            flex: 3,
            child: SizedBox(
              height: 45,
              child: VoiceWaveWidget(soundLevel: _soundLevel),
            ),
          ),
        ],
      ),
    );
  }
}

class VoiceWaveWidget extends StatelessWidget {
  final double soundLevel;

  const VoiceWaveWidget({super.key, required this.soundLevel});

  @override
  Widget build(BuildContext context) {
    /*
      soundLevel في بعض الأجهزة:
      0   = صمت
      10+ = صوت واضح

      نقوم بتحويله إلى قيمة بين 0 و 1
    */

    final volume = (soundLevel / 15).clamp(0.0, 1.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: CrossAxisAlignment.center,

      children: List.generate(18, (index) {
        /*
            توزيع مختلف لكل عمود
            حتى لا تصبح كل الموجة بنفس الارتفاع
          */

        final factor = 0.35 + ((index % 5) / 5);

        final height = 6 + (volume * 35 * factor);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 120),

          curve: Curves.easeOut,

          margin: const EdgeInsets.symmetric(horizontal: 2),

          width: 4,

          height: height,

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}

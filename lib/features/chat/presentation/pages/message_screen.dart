import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // HapticFeedback هنا
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurants_menu/common/extensions/extensions.dart';
import 'package:restaurants_menu/core/di/injection.dart';
import 'package:restaurants_menu/features/chat/domin/use_cases/send_message_use_case.dart';
import '../../../../common/design/src/theme/toaster.dart';
import '../../../../common/design/src/widgets/app_text_field.dart';
import '../../../../common/extensions/src/color_extentions.dart';
import '../../../../common/helper/src/locale_keys.dart';
import '../../../chat/presentation/bloc/chat_bloc.dart';
import '../../../review/presentation/widgets/app_bar_widget.dart';
import '../widgets/chat_input_widget.dart';
import '../widgets/message_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessageScreen> {
  late final ChatBloc chatBloc;
  late TextEditingController controller1;
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  late final GlobalKey<FormState> _globalKey3;
  final Stopwatch _recordingStopwatch = Stopwatch();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  late final ValueNotifier<bool> _hasText;
  bool _isRecording = false;
  bool isInit = true;

  Future<bool> _checkMicPermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    } else {
      await _recorder.openRecorder();
      await _recorder.startRecorder(toFile: 'voice.m4a', codec: Codec.aacMP4);
      setState(() => _isRecording = true);
    }
    return status.isGranted;
  }

  Future<File?> _stopRecording() async {
    final path = await _recorder.stopRecorder();
    setState(() => _isRecording = false);
    if (path != null) return File(path);
    return null;
  }

  void _textListener() {
    _hasText.value = controller1.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    chatBloc = getIt<ChatBloc>();
    _globalKey3 = GlobalKey();
    controller1 = TextEditingController();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _hasText = ValueNotifier<bool>(controller1.text.trim().isNotEmpty);
    controller1.addListener(_textListener);
  }

  @override
  void dispose() {
    controller1.removeListener(_textListener);
    if (_recorder.isRecording) {
      _recorder.stopRecorder();
    }
    _recorder.closeRecorder();
    _hasText.dispose();
    controller1.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  // padding: EdgeInsetsDirectional.only(top: 14),
                  height: context.height * 0.84,
                  child: state.messages.isEmpty
                      ? SizedBox()
                      : RefreshIndicator(
                          onRefresh: () async {
                            // chatBloc.add(
                            //   ChatGetDetailsEvent(
                            //     chatId: widget.arg.chat.conversationId!,
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(
                                context,
                              ).viewInsets.bottom,
                            ),
                            child: CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MessageWidget(
                                        message: state.messages[index],
                                        chatBloc: chatBloc,
                                        index: index,
                                      ),
                                    ),

                                    childCount: state.messages.length,
                                  ),
                                ),
                              ],

                              controller: _scrollController,
                              // physics: BouncingScrollPhysics(),
                            ),
                          ),
                        ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: context.navigationBarHeight + 10,

                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ChatInputWidget(
                    chatBloc: chatBloc,
                    globalKey: _globalKey3,
                  ),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          // state.getListenerMessagesData.listenerFunction(onSuccess: (){
          //   if(state.getListenerMessagesData.data!.senderId != AppVariables.user.id) {
          //     print('listen to down');
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       Future.delayed(const Duration(milliseconds: 100), () {
          //         _scrollToBottom();
          //       });
          //     });
          //   }
          // });
          if (state.chatData.isSuccess && isInit) {
            //  isInit = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(milliseconds: 100), () {
                _scrollToBottom();
              });
            });
          }
        },
      ),
    );
  }

  Widget _buildMessageInput(GlobalKey<FormState> globalKey3) {

    return Form(
      key: globalKey3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isRecording)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.primarySwatch.derivedColor,
                      context.primarySwatch,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 1.4),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: _isRecording ? scale : 1.0,
                          child: const Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 24,
                          ),
                        );
                      },
                      onEnd: () {
                        if (_isRecording) setState(() {});
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      LocaleKeys.audioRecording.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black26,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 5,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white70, Colors.white38],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          width: _isRecording
                              ? math.Random().nextDouble() * 100 + 50
                              : 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 56,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 56,
                    child: GestureDetector(
                      onTap: () {
                        if (controller1.text.trim().isNotEmpty) {
                          chatBloc.add(
                            SendMessageEvent(
                              params: SendMessageParams(
                                message: controller1.text,
                              ),
                            ),
                          );

                          controller1.clear();

                          Future.delayed(const Duration(milliseconds: 300), () {
                            _scrollToBottom();
                          });
                        }
                      },
                      onLongPressStart: (_) async {
                        if (controller1.text.trim().isEmpty) {
                          await _checkMicPermission();

                          HapticFeedback.vibrate();

                          _recordingStopwatch.reset();
                          _recordingStopwatch.start();
                        }
                      },
                      onLongPressEnd: (_) async {
                        if (controller1.text.trim().isEmpty) {
                          _recordingStopwatch.stop();

                          if (_recordingStopwatch.elapsed.inSeconds >= 2) {
                            final file = await _stopRecording();

                            if (file != null) {
                              final List<File> list = [file];

                              // chatBloc.add(
                              //   SendMessageEvent(
                              //     params: SendMessageParams(
                              //       content: null,
                              //       chatId: widget.arg.chat.conversationId!,
                              //     ),
                              //   ),
                              // );
                            }

                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                _scrollToBottom();
                              },
                            );
                          } else {
                            await _stopRecording();

                            Toaster.showText(
                              text: LocaleKeys.audioMessageShort.tr(),
                            );
                          }
                        }
                      },
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _hasText,
                        builder: (context, hasText, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: context.primarySwatch,
                            ),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: Icon(
                                hasText
                                    ? Icons.send_outlined
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

  void _scrollToBottom() {
    if (!_scrollController.hasClients) {
      print("⚠️ ScrollController not attached yet.");
      return;
    }

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + bottomInset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

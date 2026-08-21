import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:restaurants_menu/features/chat/domin/use_cases/send_message_use_case.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/helper.dart';
import '../../../chat/presentation/bloc/chat_bloc.dart';
import '../../data/model/chat_response.dart';
import 'message_bubble.dart';

class MessageWidget extends StatelessWidget {
  final ChatBloc chatBloc;
  final MessageModel message;
  final int index;

  const MessageWidget({
    super.key,
    required this.chatBloc,
    required this.message,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isVoice =
        (message.content == null || message.content == 'Audio Message');
    final bool isMe = message.isMe;
    final isArabic = context.locale.languageCode == 'ar';
    return Align(
      alignment: isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,

      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: chatBloc,
        builder: (context, state) {
          return GestureDetector(
            onTap: state.messages[index].status == PostMessageState.fail
                ? () {
                    chatBloc.add(
                      SendMessageEvent(
                        params: SendMessageParams(
                          message: message.content!, // لو كانت نصية أو صوتية
                        ),
                      ),
                    );
                  }
                : null,
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                MessageBubble(
                  isArabic: isArabic,
                  isMe: isMe,
                  child: Text(
                    message.content!,
                    style: context.headlineMedium(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color:isMe? context.textColor :context.cardColor
                    ),
                    softWrap: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: isMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (isMe)
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: switch (state.messages[index]!.status) {
                          PostMessageState.init ||
                          PostMessageState.load => const Icon(
                            Icons.access_time_outlined,
                            color: Colors.grey,
                            size: 15,
                          ),
                          PostMessageState.suc => const Icon(
                            Icons.check,
                            color: Colors.grey,
                            size: 15,
                          ),
                          PostMessageState.post => const Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                            size: 15,
                          ),
                          PostMessageState.fail => Icon(
                            Icons.sms_failed_outlined,
                            color: Colors.red,
                            size: 15,
                          ),
                        },
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChatBubbleClipper extends CustomClipper<Path> {
  final bool isMe;

  ChatBubbleClipper({required this.isMe});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (isMe) {
      // Tail on the left
      path.moveTo(10, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(10, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - 10);
      path.lineTo(0, 10);
      path.quadraticBezierTo(0, 0, 10, 0);
    } else {
      // Tail on the right
      path.moveTo(0, 0);
      path.lineTo(size.width - 10, 0);
      path.quadraticBezierTo(size.width, 0, size.width, 10);
      path.lineTo(size.width, size.height - 10);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - 10,
        size.height,
      );
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class VoiceMessageWidget extends StatefulWidget {
  final FilesModel file;

  const VoiceMessageWidget({Key? key, required this.file}) : super(key: key);

  @override
  State<VoiceMessageWidget> createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    await _player.openPlayer();

    _player.onProgress!.listen((event) {
      setState(() {
        _position = event.position;
        _duration = event.duration;
      });
    });

    _player.setSubscriptionDuration(const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _player.pausePlayer();
      setState(() => _isPlaying = false);
    } else {
      await _player.startPlayer(
        fromURI: widget.file.url,

        whenFinished: () {
          setState(() {
            _isPlaying = false;
            _position = Duration.zero;
          });
        },
      );
      setState(() => _isPlaying = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.black,
          ),
          onPressed: _togglePlay,
        ),
        const SizedBox(width: 5),
        Text(
          "${_formatTime(_position)} / ${_formatTime(_duration)}",
          style: context.headlineMedium(
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}



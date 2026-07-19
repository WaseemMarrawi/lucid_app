part of 'chat_bloc.dart';

sealed class ChatEvent {}


class AddToListEvent extends ChatEvent{}

class SendMessageEvent extends ChatEvent{
  final SendMessageParams params;

  SendMessageEvent({required this.params});
}

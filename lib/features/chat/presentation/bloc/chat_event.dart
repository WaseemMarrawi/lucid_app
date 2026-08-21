part of 'chat_bloc.dart';

sealed class ChatEvent {}


class AddToListEvent extends ChatEvent{}

class SendMessageEvent extends ChatEvent{
  final SendMessageParams params;

  SendMessageEvent({required this.params});
}
class SendVoiceEvent extends ChatEvent{
  final SendVoiceParams params;

  SendVoiceEvent({required this.params});
}
class SentDisableEvent extends ChatEvent{}
class SentInitEvent extends ChatEvent{}
class SentListenEvent extends ChatEvent{}
class SentLoadingEvent extends ChatEvent{}
class SentAiSpeakEvent extends ChatEvent{}
class SentFailedEvent extends ChatEvent{}
class ResetVoiceEvent extends ChatEvent{}
class ResetAfterFinishVoiceEvent extends ChatEvent{}

part of 'chat_bloc.dart';

class ChatState {
  final List<MessageModel> messages;
  final DataStateModel<ChatResponse?> chatData;

  ChatState({
    this.chatData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
   this.messages=const[]
  });

  ChatState copyWith({
    DataStateModel<ChatResponse?>? chatData,
     List<MessageModel>? messages

  }
      ) {
    return ChatState(
      chatData: chatData ?? this.chatData,
      messages: messages ?? this.messages,
    );
  }
}

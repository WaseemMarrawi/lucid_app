part of 'chat_bloc.dart';

class ChatState {
  final List<MessageModel> messages;
  final DataStateModel<ChatResponse?> chatData;
  final DataStateModel<VoiceResponse?> voiceData;
  final VoiceChatState voiceChatState;

  ChatState({
    this.chatData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
    this.voiceData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
   this.messages=const[],
    this.voiceChatState=VoiceChatState.disable
  });

  ChatState copyWith({
    DataStateModel<ChatResponse?>? chatData,
    DataStateModel<VoiceResponse?>? voiceData,
     List<MessageModel>? messages,
     VoiceChatState? voiceChatState

  }
      ) {
    return ChatState(
      chatData: chatData ?? this.chatData,
      voiceData: voiceData ?? this.voiceData,
      messages: messages ?? this.messages,
      voiceChatState: voiceChatState ?? this.voiceChatState,
    );
  }
}
enum VoiceChatState {
  disable,
  // init,
  listening,
  loading,
  aiSpeaking,
  failed,
}

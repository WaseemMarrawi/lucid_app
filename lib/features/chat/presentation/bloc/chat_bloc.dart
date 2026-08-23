import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/features/chat/data/model/chat_response.dart';
import 'package:restaurants_menu/features/chat/data/model/voice_response.dart';
import 'package:restaurants_menu/features/chat/domin/use_cases/send_message_use_case.dart';
import 'package:uuid/uuid.dart';
import '../../domin/use_cases/send_voice_use_case.dart';

part 'chat_event.dart';

part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase _sendMessageUseCase;
  final SendVoiceUseCase _sendVoiceUseCase;

  ChatBloc(this._sendMessageUseCase,this._sendVoiceUseCase) : super(ChatState()) {
    on<SendMessageEvent>(_sendMessage);
    on<SendVoiceEvent>(_sendVoice);
    on<SentDisableEvent>(_onSentDisable);

    // on<SentInitEvent>(_onSentInit);

    on<SentListenEvent>(_onSentListen);

    on<SentLoadingEvent>(_onSentLoading);

    on<SentAiSpeakEvent>(_onSentAiSpeak);
    on<SentFailedEvent>(_onSentFailed);
    on<ResetVoiceEvent>(_resetVoice);
    on<ResetAfterFinishVoiceEvent>(_resetAfterFinishVoice);
  }




  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  )
  async {
    final String random = const Uuid().v4();
    final MessageModel message = MessageModel(
      content: event.params.message,
      isMe: true,
      status: PostMessageState.load,
      id: random,
    );

    final List<MessageModel> list = [...state.messages, message];

    emit(state.copyWith(chatData: state.chatData.setLoading(), messages: list));

    final val = await _sendMessageUseCase(event.params);

    val.fold(
      (l) {
        final List<MessageModel> list = List.from(
          state.messages.map(
            (e) =>
                e.id == random ? e.copyWith(status: PostMessageState.fail) : e,
          ),
        );

        emit(
          state.copyWith(
            chatData: state.chatData.setFaild(errorMessage: l.message),
            messages: list,
          ),
        );
      },
      (r) {
        final List<MessageModel> firstList = List.from(
          state.messages.map(
            (e) =>
                e.id == random ? e.copyWith(status: PostMessageState.suc) : e,
          ),
        );

        final List<MessageModel> list = [...firstList, r.messageModel!];

        emit(
          state.copyWith(
            chatData: state.chatData.setSuccess(data: r),
            messages: list,
          ),
        );
      },
    );
    if (emit.isDone) return;

    emit(state.copyWith(chatData: state.chatData.resetData()));
  }

  ////

  FutureOr<void> _sendVoice(SendVoiceEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(voiceData: state.voiceData.setLoading()));
    add(SentLoadingEvent());

    final val = await _sendVoiceUseCase(event.params);

    val.fold(
          (l) {
        emit(
          state.copyWith(
            voiceData: state.voiceData.setFaild(errorMessage: l.message),
          ),
        );
        add(SentFailedEvent());

      },
          (r) {
        emit(state.copyWith(voiceData: state.voiceData.setSuccess(data: r)));
        add(SentAiSpeakEvent());




      },
    );
    // if (emit.isDone) return;
    //
    // emit(state.copyWith( voiceData: state.voiceData.resetData()));
  }





  void _onSentDisable(
      SentDisableEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(
      state.copyWith(
        voiceChatState: VoiceChatState.disable,
      ),
    );
  }

  // void _onSentInit(
  //     SentInitEvent event,
  //     Emitter<ChatState> emit,
  //     )
  // {
  //   emit(
  //     state.copyWith(
  //       voiceChatState: VoiceChatState.init,
  //     ),
  //   );
  // }

  void _onSentListen(
      SentListenEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(
      state.copyWith(
        voiceChatState: VoiceChatState.listening,
      ),
    );
  }

  void _onSentLoading(
      SentLoadingEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(
      state.copyWith(
        voiceChatState: VoiceChatState.loading,
      ),
    );
  }

  void _onSentAiSpeak(
      SentAiSpeakEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(
      state.copyWith(
        voiceChatState: VoiceChatState.aiSpeaking,
      ),
    );
  }
  void _onSentFailed(
      SentFailedEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(
      state.copyWith(
        voiceChatState: VoiceChatState.failed,
      ),
    );
  }

  void _resetVoice(
      ResetVoiceEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(state.copyWith( voiceData: state.voiceData.resetData()));
  }
  void _resetAfterFinishVoice(
      ResetAfterFinishVoiceEvent event,
      Emitter<ChatState> emit,
      ) {
    emit(state.copyWith( voiceData: state.voiceData.resetData(),voiceChatState: VoiceChatState.listening));

  }
}

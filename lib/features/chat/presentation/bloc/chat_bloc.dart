import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/features/chat/data/model/chat_response.dart';
import 'package:restaurants_menu/features/chat/domin/use_cases/send_message_use_case.dart';
import 'package:uuid/uuid.dart';

import '../widgets/message_widget.dart';

part 'chat_event.dart';

part 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase _sendMessageUseCase;

  ChatBloc(this._sendMessageUseCase) : super(ChatState()) {
    on<SendMessageEvent>(_sendMessage);
    on<AddToListEvent>(_addMessage);
  }

  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
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

  FutureOr<void> _addMessage(
    AddToListEvent event,
    Emitter<ChatState> emit,
  ) async {
    // emit(state.copyWith(chatData: state.chatData.setLoading()));
    //
    // final val = await _sendMessageUseCase(event.params);
    //
    // val.fold(
    //       (l) {
    //     emit(
    //       state.copyWith(
    //         chatData: state.chatData.setFaild(errorMessage: l.message),
    //       ),
    //     );
    //   },
    //       (r) {
    //     emit(state.copyWith(chatData: state.chatData.setSuccess(data: r)));
    //
    //   },
    // );
    // if (emit.isDone) return;
    //
    // emit(state.copyWith(chatData: state.chatData.resetData()));
  }
}

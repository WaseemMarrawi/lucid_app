
import 'package:uuid/uuid.dart';

ChatResponse chatResponseFromJson( str) => ChatResponse.fromJson(str);


class ChatResponse {
  final bool? success;
  final String? message;
  final MessageModel? messageModel;

  ChatResponse({
    this.success,
    this.message,
    this.messageModel,
  });

  ChatResponse copyWith({
    bool? success,
    String? message,
    MessageModel? messageModel,
  }) =>
      ChatResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        messageModel: messageModel ?? this.messageModel,
      );

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
    success: json["success"],
    message: json["message"],
    messageModel: json["data"] == null ? null : MessageModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": messageModel?.toJson(),
  };
}




class MessageModel {
  final String id;
  final String? content;
  final bool isMe;
  final PostMessageState status;
  final String? event;
  final String? conversationId;

  MessageModel({
    required this.id,
    this.content,
    this.conversationId,
    this.event,
    this.isMe = false,
    this.status = PostMessageState.init,
  });
  MessageModel copyWith({
    String? id,
    String? content,
    bool? isMe,
    PostMessageState? status,
    String? event,
    String? conversationId,

  }
      ) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      isMe: isMe ?? this.isMe,
      status: status ?? this.status,
      event: event ?? this.event,
      conversationId: conversationId ?? this.conversationId,
    );
  }



  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    event: json["event"],
    conversationId: json["conversation_id"],
    content: json["answer"],
    id:   Uuid().v4()

  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "conversation_id": conversationId,
    "answer": content,
  };
}

enum PostMessageState { init, load, suc, fail, post }

class FilesModel {
  final String? url;
  final String? name;
  final String? type;

  FilesModel({this.url, this.name, this.type});

  FilesModel copyWith({String? url, String? name, String? type}) => FilesModel(
    url: url ?? this.url,
    name: name ?? this.name,
    type: type ?? this.type,
  );

  factory FilesModel.fromJson(Map<String, dynamic> json) =>
      FilesModel(url: json["url"], name: json["name"], type: json["type"]);

  Map<String, dynamic> toJson() => {"url": url, "name": name, "type": type};
}
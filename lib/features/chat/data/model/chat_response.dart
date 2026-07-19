


import 'package:restaurants_menu/features/chat/presentation/widgets/message_widget.dart';

import '../../../../common/models/offer_model.dart';

ChatResponse chatResponseFromJson(str) => ChatResponse.fromJson(str);


class ChatResponse {
  final bool? success;
  final MessageModel? messageModel;
  final OfferModel? data;

  ChatResponse({
    this.success,
    this.messageModel,
    this.data,
  });

  ChatResponse copyWith({
    bool? success,
    String? message,
    OfferModel? data,
  }) =>
      ChatResponse(
        success: success ?? this.success,
        messageModel: messageModel ?? this.messageModel,
        data: data ?? this.data,
      );

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
    success: json["success"],
    messageModel: json["message"],
    data: json["data"] == null ? null : OfferModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": messageModel,
    "data": data?.toJson(),
  };
}



import '../../../../common/models/offer_model.dart';

OfferCodeResponse offerCodeResponseFromJson( str) => OfferCodeResponse.fromJson(str);


class OfferCodeResponse {
  final bool? success;
  final String? message;
  final OfferModel? data;

  OfferCodeResponse({
    this.success,
    this.message,
    this.data,
  });

  OfferCodeResponse copyWith({
    bool? success,
    String? message,
    OfferModel? data,
  }) =>
      OfferCodeResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OfferCodeResponse.fromJson(Map<String, dynamic> json) => OfferCodeResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : OfferModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}


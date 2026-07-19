
import '../../../../common/models/review_model.dart';

ReviewResponse reviewServiceResponseFromJson(str) =>
    ReviewResponse.fromJson(str);

class ReviewResponse {
  final ReviewModel? data;

  ReviewResponse({this.data});

  ReviewResponse copyWith({ReviewModel? data}) =>
      ReviewResponse(data: data ?? this.data);

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
    data: json["data"] == null ? null : ReviewModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"data": data?.toJson()};
}

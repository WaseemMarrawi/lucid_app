import 'package:injectable/injectable.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/model/review_response.dart';
import '../repositories/review_repositories.dart';

@lazySingleton
class ReviewServiceUseCase
    implements UseCase<ReviewResponse, ReviewServiceParams> {
  final ReviewRepositories _repositories;

  ReviewServiceUseCase({required ReviewRepositories repositories})
    : _repositories = repositories;

  @override
  DataResponse<ReviewResponse> call(ReviewServiceParams params) async =>
      await _repositories.reviewService(params);
}

class ReviewServiceParams with Params {
  final String? customerPhone;
  final String? tableNumber;
  final double serviceRate;
  final double cleanRate;
  final double foodRate;
  final String experience;
  final String? notes;

  ReviewServiceParams({
    required this.serviceRate,
    required this.cleanRate,
    required this.foodRate,
    required this.customerPhone,
    required this.experience,
    required this.tableNumber,
    required this.notes,
  });

  @override
  BodyMap getBody() {
    // TODO: implement getBody
    return {
      "service_rating": serviceRate,
      "cleanliness_rating": cleanRate,
      "food_rating": foodRate,
      "customer_phone": customerPhone,
      "table_number": tableNumber,
      "experience": experience, //required
      "notes": notes



    }
      ..removeWhere((key, value) => value == null || value == '');
  }
}

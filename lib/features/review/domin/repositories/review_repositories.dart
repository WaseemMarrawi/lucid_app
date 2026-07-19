import '../../../../common/helper/src/typedef.dart';
import '../../data/model/review_response.dart';
import '../use_cases/review_service_use_case.dart';

abstract class ReviewRepositories{

  DataResponse <ReviewResponse>  reviewService(ReviewServiceParams params);



}
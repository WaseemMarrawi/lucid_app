import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/error/error_handeler.dart';
import 'package:injectable/injectable.dart';
import '../../domin/repositories/review_repositories.dart';
import '../../domin/use_cases/review_service_use_case.dart';
import '../data_source/review_data_source.dart';
import '../model/review_response.dart';

@LazySingleton(as: ReviewRepositories)
class ReviewRepositoriesImp
    with HandlingException
    implements ReviewRepositories {
  final ReviewDataSource _remoteData;

  ReviewRepositoriesImp({required ReviewDataSource remoteData})
    : _remoteData = remoteData;



  @override
  DataResponse<ReviewResponse> reviewService(ReviewServiceParams params) async {
    return wrapHandlingException(
      tryCall: () => _remoteData.reviewService(params),
    );
  }
}

import 'package:injectable/injectable.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/model/get_all_product_response.dart';
import '../repositories/product_repositories.dart';

@lazySingleton
class GetAllProductUseCase
    implements UseCase<GetAllProductResponse, NoParams> {
  final ProductRepositories _repositories;

  GetAllProductUseCase({required ProductRepositories repositories})
    : _repositories = repositories;

  @override
  DataResponse<GetAllProductResponse> call(NoParams params) async =>
      await _repositories.getAllProduct();
}


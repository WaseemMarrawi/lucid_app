import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/error/error_handeler.dart';
import '../../domin/repositories/product_repositories.dart';
import 'package:injectable/injectable.dart';
import '../data_source/product_remote_data.dart';
import '../model/get_all_product_response.dart';

@LazySingleton(as: ProductRepositories)
class ProductRepositoriesImp
    with HandlingException
    implements ProductRepositories {
  final ProductRemoteData _remoteData;

  ProductRepositoriesImp({required ProductRemoteData remoteData})
    : _remoteData = remoteData;

  @override
  DataResponse<GetAllProductResponse> getAllProduct() async =>
      wrapHandlingException(tryCall: () => _remoteData.getAllProduct());

}

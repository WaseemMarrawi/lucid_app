import '../../../../common/helper/src/typedef.dart';
import '../../data/model/get_all_product_response.dart';

abstract class ProductRepositories {
  DataResponse<GetAllProductResponse> getAllProduct();

}

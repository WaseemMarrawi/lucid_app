import 'package:injectable/injectable.dart';
import 'package:restaurants_menu/features/cart/data/model/offer_code_response.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/error/error_handeler.dart';
import '../../domin/repositories/cart_repositores.dart';
import '../data_source/cart_remote_data.dart';

@LazySingleton(as: CartRepositories)
class CartRepositoriesImp with HandlingException implements CartRepositories {
  final CartRemoteData _remoteData;

  CartRepositoriesImp({required CartRemoteData remoteData})
      : _remoteData = remoteData;

  @override
  DataResponse<void> sendCart(BodyMap params) async =>
      wrapHandlingException(tryCall: () => _remoteData.sendCart(params));

  @override
  DataResponse<OfferCodeResponse> getOfferCode(BodyMap params) async =>
      wrapHandlingException(tryCall: () => _remoteData.getOfferCode(params));





}

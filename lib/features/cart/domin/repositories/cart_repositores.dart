import 'package:restaurants_menu/features/cart/data/model/offer_code_response.dart';

import '../../../../common/helper/src/typedef.dart';





abstract class CartRepositories {
  // DataResponse<GetCartResponse> getCart(QueryParams params);
  // DataResponse<PostToCartResponse> addToCart(AddToCartParams params);
  // DataResponse<void> deleteCart(int id);
  // DataResponse<CheckOutResponse> checkoutCart();


  DataResponse<void> sendCart(BodyMap params);
  DataResponse<OfferCodeResponse> getOfferCode(BodyMap params);


}


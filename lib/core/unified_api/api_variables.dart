import 'dart:developer';
import '../../common/extensions/src/log_colors_extension.dart';
import '../../common/helper/src/typedef.dart';

class ApiVariables {
  ApiVariables._();

  static const scheme = 'https';
  static const host = "lucid.eidosteam.com";

  static Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: scheme,
      host: host,
      path: 'api/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString().logMagenta);
    return uri;
  }

  //version
  static Uri getVersion() => _mainUri(path: 'app/version/check');

  ///Auth///

  static Uri _auth({required String path}) => _mainUri(path: 'auth/$path');

  static Uri login() => _auth(path: "login");

  static Uri signup() => _auth(path: "register");

  static Uri confirm() => _auth(path: "verify-email");

  static Uri forget() => _auth(path: "password/request-code");

  static Uri forgetVerify() => _auth(path: "password/verify-code");

  static Uri forgetReset() => _auth(path: "password/reset");

  static Uri logOut() => _auth(path: "logout");

  //cart
  static Uri postToCart()=>_mainUri(path: '');

  ////product
  static Uri searchProduct() => _mainUri(path: "tracking/lookup");
  static Uri getProductDetails(String id) => _mainUri(path: "tracked-shipments/$id");
  static Uri getAllProduct( ) => _mainUri(path: "restaurant/menu/offline");
  static Uri trackShipment() => _mainUri(path: "tracked-shipments");


  static Uri _user({required String path, QueryParams? queryParameters}) =>
      _mainUri(path: 'user/$path', queryParameters: queryParameters);

  static Uri getMe() => _mainUri(path: "auth/me");

  static Uri updateMe() => _user(path: "profile");

  static Uri deleteMe() => _user(path: "profile");

  static Uri postProfileImage() => _user(path: "profile/avatar");

  static Uri getMinePhotos(QueryParams queryParams) =>
      _user(path: "myPhotos", queryParameters: queryParams);

  static Uri updateMyPassword() => _user(path: "updateMyPassword");

  //cars

  static Uri _cars({String? path, QueryParams? queryParameters}) => _mainUri(
    path: path == null ? 'cars' : 'cars/$path',
    queryParameters: queryParameters,
  );

  static Uri getCars(QueryParams params) => _cars(queryParameters: params);

  static Uri postCar() => _cars();

  static Uri getCarDetails(int id) => _cars(path: '$id');

  static Uri deleteCar(int id) => _cars(path: '$id');

  static Uri updateCar(int id) => _cars(path: '$id');

  static Uri setDefaultCar(int id) => _cars(path: '$id/set-default');

  static Uri updateLocationCar(int id) => _cars(path: '$id/update-location');

  static Uri getDefaultCar() => _cars(path: '/default');

  static Uri getCities() => _mainUri(path: 'cities');

  static Uri getAttributes() => _mainUri(path: 'brands');

  ///////cart
  static Uri sendCart() => _mainUri(path: 'restaurant/orders');
  static Uri offerCode() => _mainUri(path: 'restaurant/orders/offer-code/validate');


  static Uri _cart(String path) => _mainUri(path: 'cart/$path');

  static Uri addToCart() => _cart('add');

  static Uri putCart() => _cart('update');

  static Uri deleteCart() => _cart('remove');

  static Uri clearCart() => _cart('clear');

  static Uri checkOutCart() => _cart('checkout');

  static Uri checkStockCart() => _cart('check-stock');

  //////////service

  static Uri getAdvert() => _mainUri(path: 'getAdvert');

  static Uri _service({String? path, QueryParams? queryParams}) {
    final fullPath = path == null ? 'service/' : 'service/$path';
    return _mainUri(path: fullPath, queryParameters: queryParams ?? {});
  }

  static Uri getAllService(QueryParams queryParams) =>
      _service(queryParams: queryParams);

  static Uri getOneService(int id) => _service(path: '$id');

  ////////category

  static Uri _category({String? path, QueryParams? queryParams}) {
    final fullPath = path == null ? 'category/' : 'category/$path';
    return _mainUri(path: fullPath, queryParameters: queryParams ?? {});
  }

  static Uri getAllCategory(QueryParams queryParams) =>
      _category(queryParams: queryParams, path: 'all');

  //accessories

  static Uri getAllAccess(QueryParams queryParams) =>
      _mainUri(queryParameters: queryParams, path: 'accessories');

  static Uri getAccessDetails(int id) => _mainUri(path: 'accessories/$id');

  //service

  static Uri getAllServices() => _mainUri(path: 'services');

  static Uri getService(int id) => _mainUri(path: 'services/$id');

  //banners
  static Uri getBanners() => _mainUri(path: 'carousels');

  //////////////////////////////////////////////////////////////////////////

  //order
  static Uri _orders({String? path, QueryParams? params}) =>
      _mainUri(path: 'orders${path ?? ''}', queryParameters: params);

  static Uri getAllOrders(QueryParams params) => _orders(params: params);

  static Uri postOrder() => _orders();

  static Uri getOrder(int id) => _orders(path: '/$id');

  static Uri deleteOrder(int id) => _orders(path: '/$id');

  static Uri checkOutOrder(int id) => _orders(path: '/$id/checkout');

  //packages
  static Uri _package({String? path, QueryParams? params}) =>
      _mainUri(path: 'packages${path ?? ''}', queryParameters: params);

  static Uri getAllPackages() => _package();

  static Uri getPackage(int id) => _package(path: '/$id');

  ///notification

  static Uri getAllNotification(QueryParams queryParams) =>
      _mainUri(path: 'notifications', queryParameters: queryParams);

  static Uri postMarkAllNotification() =>
      _mainUri(path: 'notifications/read-all');

  static Uri deleteNotification(String id) =>
      _mainUri(path: 'user/notifications/$id');

  static Uri confirmExtra(int id) =>
      _mainUri(path: 'orders/$id/confirm-instant');

  static Uri rejectExtra(int id) =>
      _mainUri(path: 'orders/$id/reject-instant-service');


  //review

  static Uri reviewService() =>
      _mainUri(path: 'restaurant/reviews');


  //ai
  static Uri sendMessage() =>
      _mainUri(path: 'restaurant/ai/chat');

}

import '../../common/helper/helper.dart';

abstract class UseCase<Type, Params> {
  DataResponse<Type> call(Params params);
}

mixin Params {
  BodyMap getBody() => {};

  QueryParams getParams() => {};
}

class NoParams with Params {}

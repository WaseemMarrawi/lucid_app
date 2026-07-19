// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hydrated_bloc/hydrated_bloc.dart' as _i67;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../common/design/src/theme/theme/theme_notifier.dart' as _i291;
import '../../common/helper/src/internet_service.dart' as _i685;
import '../../features/auth/data/data_sources/auth_remote_data.dart' as _i653;
import '../../features/auth/data/repositories/auth_repositories_imp.dart'
    as _i855;
import '../../features/auth/domain/repositories/auth_repositories.dart'
    as _i962;
import '../../features/auth/domain/use_cases/confirm_use_case.dart' as _i187;
import '../../features/auth/domain/use_cases/forget_password_reset_use_case.dart'
    as _i209;
import '../../features/auth/domain/use_cases/forget_password_use_case.dart'
    as _i483;
import '../../features/auth/domain/use_cases/forget_password_verify_use_case.dart'
    as _i237;
import '../../features/auth/domain/use_cases/log_out_use_case.dart' as _i446;
import '../../features/auth/domain/use_cases/login_use_case.dart' as _i1038;
import '../../features/auth/domain/use_cases/signup_use_case.dart' as _i571;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/cart/data/data_source/cart_remote_data.dart' as _i47;
import '../../features/cart/data/repositories/cart_repositories_imp.dart'
    as _i1008;
import '../../features/cart/domin/repositories/cart_repositores.dart' as _i186;
import '../../features/cart/domin/use_cases/get_offer_code_use_case.dart'
    as _i105;
import '../../features/cart/domin/use_cases/send_cart_use_case.dart' as _i373;
import '../../features/cart/presentation/bloc/cart_bloc.dart' as _i517;
import '../../features/chat/data/data_source/chat_remote_data.dart' as _i938;
import '../../features/chat/data/repositories/chat_repositories_imp.dart'
    as _i712;
import '../../features/chat/domin/repositories/chat_repositories.dart' as _i72;
import '../../features/chat/domin/use_cases/send_message_use_case.dart'
    as _i837;
import '../../features/chat/presentation/bloc/chat_bloc.dart' as _i65;
import '../../features/product/data/data_source/product_remote_data.dart'
    as _i197;
import '../../features/product/data/repositories/product_repositories_imp.dart'
    as _i278;
import '../../features/product/domin/repositories/product_repositories.dart'
    as _i869;
import '../../features/product/domin/use_cases/get_all_product_use_case.dart'
    as _i176;
import '../../features/product/presentation/bloc/product_bloc.dart' as _i415;
import '../../features/review/data/data_source/review_data_source.dart'
    as _i304;
import '../../features/review/data/repositories/review_repositories_imp.dart'
    as _i203;
import '../../features/review/domin/repositories/review_repositories.dart'
    as _i597;
import '../../features/review/domin/use_cases/review_service_use_case.dart'
    as _i538;
import '../../features/review/presentation/bloc/review_bloc.dart' as _i610;
import '../../features/splash/data/data_sources/version_remote_data.dart'
    as _i328;
import '../../features/splash/data/repositories/version_repositories_imp.dart'
    as _i837;
import '../../features/splash/domain/repositories/version_repositories.dart'
    as _i16;
import '../../features/splash/domain/use_cases/get_version_use_case.dart'
    as _i1023;
import '../../features/splash/page/cubit/splash_cubit.dart' as _i547;
import '../../features/user/data/data_sources/user_remote_data.dart' as _i15;
import '../../features/user/data/repositories/user_repositories_imp.dart'
    as _i990;
import '../../features/user/domain/repositories/user_repositories.dart' as _i91;
import '../../features/user/domain/use_cases/user_delete_me_use_cases.dart'
    as _i657;
import '../../features/user/domain/use_cases/user_get_me_use_cases.dart'
    as _i827;
import '../../features/user/domain/use_cases/user_update_me_use_cases.dart'
    as _i584;
import '../../features/user/domain/use_cases/user_update_profile_use_cases.dart'
    as _i743;
import '../../features/user/presentation/bloc/user_bloc.dart' as _i747;
import '../unified_api/dio/api_client.dart' as _i357;
import '../unified_api/dio/logger_interceptor.dart' as _i614;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  await gh.factoryAsync<_i67.HydratedStorage>(
    () => injectableModule.hydratedStorage,
    preResolve: true,
  );
  gh.singleton<_i361.Dio>(() => injectableModule.dio);
  gh.lazySingleton<_i291.AppThemeNotifier>(() => _i291.AppThemeNotifier());
  gh.lazySingleton<_i685.InternetService>(() => _i685.InternetService());
  gh.lazySingleton<_i161.InternetConnection>(
    () => injectableModule.internetConnection,
  );
  gh.lazySingleton<_i614.LoggerInterceptor>(() => _i614.LoggerInterceptor());
  gh.lazySingleton<_i357.ApiClient>(
    () => _i357.ApiClient(
      gh<_i361.Dio>(),
      loggingInterceptor: gh<_i614.LoggerInterceptor>(),
    ),
  );
  gh.lazySingleton<_i653.AuthRemoteData>(
    () => _i653.AuthRemoteData(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i47.CartRemoteData>(
    () => _i47.CartRemoteData(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i938.ChatRemoteData>(
    () => _i938.ChatRemoteData(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i197.ProductRemoteData>(
    () => _i197.ProductRemoteData(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i304.ReviewDataSource>(
    () => _i304.ReviewDataSource(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i328.VersionRemoteData>(
    () => _i328.VersionRemoteData(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i15.UserRemoteData>(
    () => _i15.UserRemoteData(apiClient: gh<_i357.ApiClient>()),
  );
  gh.lazySingleton<_i962.AuthRepositories>(
    () => _i855.AuthRepositoriesImp(remoteData: gh<_i653.AuthRemoteData>()),
  );
  gh.lazySingleton<_i597.ReviewRepositories>(
    () => _i203.ReviewRepositoriesImp(remoteData: gh<_i304.ReviewDataSource>()),
  );
  gh.lazySingleton<_i91.UserRepositories>(
    () => _i990.UserRepositoriesImp(remoteData: gh<_i15.UserRemoteData>()),
  );
  gh.lazySingleton<_i186.CartRepositories>(
    () => _i1008.CartRepositoriesImp(remoteData: gh<_i47.CartRemoteData>()),
  );
  gh.lazySingleton<_i869.ProductRepositories>(
    () =>
        _i278.ProductRepositoriesImp(remoteData: gh<_i197.ProductRemoteData>()),
  );
  gh.lazySingleton<_i16.VersionRepositories>(
    () =>
        _i837.VersionRepositoriesImp(remoteData: gh<_i328.VersionRemoteData>()),
  );
  gh.lazySingleton<_i657.UserDeleteMeUseCases>(
    () => _i657.UserDeleteMeUseCases(repositories: gh<_i91.UserRepositories>()),
  );
  gh.lazySingleton<_i827.UserGetMeUseCases>(
    () => _i827.UserGetMeUseCases(repositories: gh<_i91.UserRepositories>()),
  );
  gh.lazySingleton<_i584.UserUpdateMeUseCases>(
    () => _i584.UserUpdateMeUseCases(repositories: gh<_i91.UserRepositories>()),
  );
  gh.lazySingleton<_i743.UserUpdateProfileImageUseCases>(
    () => _i743.UserUpdateProfileImageUseCases(
      repositories: gh<_i91.UserRepositories>(),
    ),
  );
  gh.factory<_i747.UserBloc>(
    () => _i747.UserBloc(
      gh<_i657.UserDeleteMeUseCases>(),
      gh<_i827.UserGetMeUseCases>(),
      gh<_i743.UserUpdateProfileImageUseCases>(),
      gh<_i584.UserUpdateMeUseCases>(),
    ),
  );
  gh.lazySingleton<_i538.ReviewServiceUseCase>(
    () => _i538.ReviewServiceUseCase(
      repositories: gh<_i597.ReviewRepositories>(),
    ),
  );
  gh.lazySingleton<_i1023.GetVersionUseCase>(
    () => _i1023.GetVersionUseCase(
      authRepositories: gh<_i16.VersionRepositories>(),
    ),
  );
  gh.lazySingleton<_i72.ChatRepositories>(
    () => _i712.ChatRepositoriesImp(remoteData: gh<_i938.ChatRemoteData>()),
  );
  gh.factory<_i547.SplashCubit>(
    () => _i547.SplashCubit(gh<_i1023.GetVersionUseCase>()),
  );
  gh.lazySingleton<_i105.GetOfferCodeUseCase>(
    () => _i105.GetOfferCodeUseCase(repositories: gh<_i186.CartRepositories>()),
  );
  gh.lazySingleton<_i373.SendCartUseCase>(
    () => _i373.SendCartUseCase(repositories: gh<_i186.CartRepositories>()),
  );
  gh.lazySingleton<_i187.ConfirmUseCase>(
    () => _i187.ConfirmUseCase(authRepositories: gh<_i962.AuthRepositories>()),
  );
  gh.lazySingleton<_i209.ForgetPasswordResetUseCase>(
    () => _i209.ForgetPasswordResetUseCase(
      authRepositories: gh<_i962.AuthRepositories>(),
    ),
  );
  gh.lazySingleton<_i483.ForgetPasswordUseCase>(
    () => _i483.ForgetPasswordUseCase(
      authRepositories: gh<_i962.AuthRepositories>(),
    ),
  );
  gh.lazySingleton<_i237.ForgetPasswordVerifyUseCase>(
    () => _i237.ForgetPasswordVerifyUseCase(
      authRepositories: gh<_i962.AuthRepositories>(),
    ),
  );
  gh.lazySingleton<_i446.LogOutUseCase>(
    () => _i446.LogOutUseCase(authRepositories: gh<_i962.AuthRepositories>()),
  );
  gh.lazySingleton<_i1038.LoginUseCase>(
    () => _i1038.LoginUseCase(authRepositories: gh<_i962.AuthRepositories>()),
  );
  gh.lazySingleton<_i571.SignupUseCase>(
    () => _i571.SignupUseCase(authRepositories: gh<_i962.AuthRepositories>()),
  );
  gh.lazySingleton<_i176.GetAllProductUseCase>(
    () => _i176.GetAllProductUseCase(
      repositories: gh<_i869.ProductRepositories>(),
    ),
  );
  gh.lazySingleton<_i837.SendMessageUseCase>(
    () => _i837.SendMessageUseCase(repositories: gh<_i72.ChatRepositories>()),
  );
  gh.factory<_i610.ReviewBloc>(
    () => _i610.ReviewBloc(gh<_i538.ReviewServiceUseCase>()),
  );
  gh.factory<_i65.ChatBloc>(
    () => _i65.ChatBloc(gh<_i837.SendMessageUseCase>()),
  );
  gh.factory<_i797.AuthBloc>(
    () => _i797.AuthBloc(
      gh<_i1038.LoginUseCase>(),
      gh<_i571.SignupUseCase>(),
      gh<_i187.ConfirmUseCase>(),
      gh<_i483.ForgetPasswordUseCase>(),
      gh<_i209.ForgetPasswordResetUseCase>(),
      gh<_i237.ForgetPasswordVerifyUseCase>(),
      gh<_i446.LogOutUseCase>(),
    ),
  );
  gh.factory<_i415.ProductBloc>(
    () => _i415.ProductBloc(gh<_i176.GetAllProductUseCase>()),
  );
  gh.lazySingleton<_i517.CartBloc>(
    () => _i517.CartBloc(
      gh<_i373.SendCartUseCase>(),
      gh<_i105.GetOfferCodeUseCase>(),
    ),
  );
  return getIt;
}

class _$InjectableModule extends _i464.InjectableModule {}

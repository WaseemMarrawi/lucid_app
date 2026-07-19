import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../common/helper/src/data_state_model.dart';
import '../../../../common/helper/src/helper_func.dart';
import '../../data/models/get_version_response.dart';
import '../../domain/use_cases/get_version_use_case.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final GetVersionUseCase _getVersionUseCase;

  SplashCubit(this._getVersionUseCase) : super(const SplashState());

  void checkNavigator() {
    if (HelperFunc.isAuth()) {

      emit(state.copyWith(splashStatus: SplashStatus.isAuth));
    } else {

      emit(state.copyWith(splashStatus: SplashStatus.unauthorized));

    }
  }

  void checkVersion() async {
    emit(state.copyWith(getVersionData: state.getVersionData.setLoading()));

    final params = await _buildVersionParams();

    final val = await _getVersionUseCase(params);

    val.fold(
          (l) {
        emit(
          state.copyWith(
            getVersionData: state.getVersionData.setFaild(
              errorMessage: l.message,
            ),
          ),
        );
      },
          (r) {
        emit(
          state.copyWith(
            getVersionData: state.getVersionData.setSuccess(data: r),
          ),
        );
      },
    );
  }

  Future<GetVersionParams> _buildVersionParams() async {
    final info = await PackageInfo.fromPlatform();

    final platform = kIsWeb
        ? "web"
        : Platform.operatingSystem;
    // ترجع مباشرة: android / ios / windows / macos / linux

    return GetVersionParams(
      platform: platform,
      currentVersion: info.version,
    );
  }
}

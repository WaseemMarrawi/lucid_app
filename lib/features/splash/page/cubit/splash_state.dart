part of 'splash_cubit.dart';

enum SplashStatus { init, isAuth, unauthorized }

class SplashState {
  final SplashStatus splashStatus;
  final DataStateModel<GetVersionResponse?> getVersionData;

  const SplashState({
    this.splashStatus = SplashStatus.init,
    this.getVersionData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
  });

  SplashState copyWith({
    SplashStatus? splashStatus,
    DataStateModel<GetVersionResponse?>? getVersionData,
  }) {
    return SplashState(
        splashStatus: splashStatus ?? this.splashStatus,
      getVersionData: getVersionData ?? this.getVersionData,

    );
  }

  @override
  String toString() => 'SplashState(splashStatus: $splashStatus)';
}

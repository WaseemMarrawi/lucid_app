part of 'auth_bloc.dart';

class AuthState {
  final DataStateModel<AuthResponse?> loginData;
  final DataStateModel<LogOutResponse?> logOutData;
  final DataStateModel<void> signData;
  final DataStateModel<AuthResponse?> confirmData;
  final DataStateModel<ForgetPasswordResponse?> forgetPasswordData;
  final DataStateModel<ForgetPasswordResponse?> forgetPasswordResetData;
  final DataStateModel<ForgetPasswordResponse?> forgetPasswordVerifyData;

  AuthState({
    this.loginData = const DataStateModel.setDefultValue(defultValue: null),
    this.logOutData = const DataStateModel.setDefultValue(defultValue: null),
    this.forgetPasswordVerifyData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
    this.signData = const DataStateModel.setDefultValue(defultValue: null),
    this.confirmData = const DataStateModel.setDefultValue(defultValue: null),
    this.forgetPasswordData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
    this.forgetPasswordResetData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
  });

  AuthState copyWith({
    DataStateModel<AuthResponse?>? loginData,
    final DataStateModel<LogOutResponse?>? logOutData,

    DataStateModel<void>? signData,
    DataStateModel<AuthResponse?>? confirmData,
    DataStateModel<ForgetPasswordResponse?>? forgetPasswordData,
    DataStateModel<ForgetPasswordResponse?>? forgetPasswordResetData,
    DataStateModel<ForgetPasswordResponse?>? forgetPasswordVerifyData,
  }) {
    return AuthState(
      loginData: loginData ?? this.loginData,
      logOutData: logOutData ?? this.logOutData,
      signData: signData ?? this.signData,
      confirmData: confirmData ?? this.confirmData,
      forgetPasswordData: forgetPasswordData ?? this.forgetPasswordData,
      forgetPasswordResetData:
          forgetPasswordResetData ?? this.forgetPasswordResetData,
      forgetPasswordVerifyData:
          forgetPasswordVerifyData ?? this.forgetPasswordVerifyData,
    );
  }
}

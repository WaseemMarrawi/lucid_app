import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurants_menu/common/design/src/theme/theme/theme_notifier.dart';
import '../../../../common/helper/src/app_varibles.dart';
import '../../../../common/helper/src/data_state_model.dart';
import '../../../../common/helper/src/helper_func.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/auth_response.dart';
import '../../data/models/forget_password_response.dart';
import '../../data/models/log_out_response.dart';
import '../../domain/use_cases/confirm_use_case.dart';
import 'package:injectable/injectable.dart';
import '../../domain/use_cases/forget_password_reset_use_case.dart';
import '../../domain/use_cases/forget_password_use_case.dart';
import '../../domain/use_cases/forget_password_verify_use_case.dart';
import '../../domain/use_cases/log_out_use_case.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../../domain/use_cases/signup_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogOutUseCase _logOutUseCase;
  final SignupUseCase _signupUseCase;
  final ConfirmUseCase _confirmUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final ForgetPasswordResetUseCase _forgetPasswordResetUseCase;
  final ForgetPasswordVerifyUseCase _forgetPasswordVerifyUseCase;

  AuthBloc(
    this._loginUseCase,
    this._signupUseCase,
    this._confirmUseCase,
    this._forgetPasswordUseCase,
    this._forgetPasswordResetUseCase,
    this._forgetPasswordVerifyUseCase,
    this._logOutUseCase,
  ) : super(AuthState()) {
    on<LoginEvent>(_login);
    on<LogOutEvent>(_logOut);
    on<SignupEvent>(_signup);
    on<ConfirmEvent>(_confirm);
    on<ForgetPasswordEvent>(_forgetPassword);
    on<ForgetPasswordResetEvent>(_forgetPasswordReset);
    on<ForgetPasswordVerifyEvent>(_forgetPasswordVerify);
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginData: state.loginData.setLoading()));

    final val = await _loginUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            loginData: state.loginData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(state.copyWith(loginData: state.loginData.setSuccess(data: r)));
        AppVariables.token = r.data!.token;
        AppVariables.user = r.data!.user!;

        getIt<AppThemeNotifier>().refreshTheme();
        getIt<ApiClient>().resetHeader();

      },
    );
    if (emit.isDone) return;

    emit(state.copyWith( loginData: state.loginData.resetData()));
  }

  FutureOr<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(logOutData: state.logOutData.setLoading()));

    final val = await _logOutUseCase(NoParams());

    val.fold(
      (l) {
        emit(
          state.copyWith(
            logOutData: state.logOutData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(state.copyWith(logOutData: state.logOutData.setSuccess()));
        HelperFunc.logout();
      },
    );
    if (emit.isDone) return;

    emit(state.copyWith( logOutData: state.logOutData.resetData()));
  }

  FutureOr<void> _signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signData: state.signData.setLoading()));

    final val = await _signupUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            signData: state.signData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(state.copyWith(signData: state.signData.setSuccess()));
      },
    );

    if (emit.isDone) return;

    emit(state.copyWith(signData: state.signData.resetData()));
  }

  FutureOr<void> _confirm(ConfirmEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(confirmData: state.confirmData.setLoading()));

    final val = await _confirmUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            confirmData: state.confirmData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(confirmData: state.confirmData.setSuccess(data: r)),
        );

        AppVariables.token = r.data!.token;
        AppVariables.user = r.data!.user!;
        getIt<ApiClient>().resetHeader();

      },
    );

    if (emit.isDone) return;

    emit(
      state.copyWith(
        confirmData: state.confirmData.resetData(),
      ),
    );
  }

  FutureOr<void> _forgetPassword(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  )
  async {
    emit(
      state.copyWith(forgetPasswordData: state.forgetPasswordData.setLoading()),
    );

    final val = await _forgetPasswordUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            forgetPasswordData: state.forgetPasswordData.setFaild(
              errorMessage: l.message,
            ),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            forgetPasswordData: state.forgetPasswordData.setSuccess(),
          ),
        );
      },
    );


    if (emit.isDone) return;

    emit(
      state.copyWith(forgetPasswordData: state.forgetPasswordData.resetData()),
    );
  }

  FutureOr<void> _forgetPasswordReset(
    ForgetPasswordResetEvent event,
    Emitter<AuthState> emit,
  )
  async {
    emit(
      state.copyWith(
        forgetPasswordResetData: state.forgetPasswordResetData.setLoading(),
      ),
    );

    final val = await _forgetPasswordResetUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            forgetPasswordResetData: state.forgetPasswordResetData.setFaild(
              errorMessage: l.message,
            ),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            forgetPasswordResetData: state.forgetPasswordResetData.setSuccess(),
          ),
        );
      },
    );


    if (emit.isDone) return;

    emit(
      state.copyWith(
        forgetPasswordResetData: state.forgetPasswordResetData.resetData(),
      ),
    );
  }

  FutureOr<void> _forgetPasswordVerify(
    ForgetPasswordVerifyEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        forgetPasswordVerifyData: state.forgetPasswordVerifyData.setLoading(),
      ),
    );

    final val = await _forgetPasswordVerifyUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            forgetPasswordVerifyData: state.forgetPasswordVerifyData.setFaild(
              errorMessage: l.message,
            ),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            forgetPasswordVerifyData: state.forgetPasswordVerifyData
                .setSuccess(),
          ),
        );
      },
    );


    if (emit.isDone) return;

    emit(
      state.copyWith(
        forgetPasswordVerifyData: state.forgetPasswordVerifyData.resetData(),
      ),
    );
  }
}

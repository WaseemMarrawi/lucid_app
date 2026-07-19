part of 'auth_bloc.dart';

sealed class AuthEvent {}


class   LoginEvent extends AuthEvent{
  final LoginParams params;
  LoginEvent({required this.params});
}
class   SignupEvent extends AuthEvent{

  final SignUpParams params;

  SignupEvent({required this.params});

}
class   ConfirmEvent extends AuthEvent{
  final ConfirmParams params;

  ConfirmEvent({required this.params});

}
class   ForgetPasswordEvent extends AuthEvent{
  final ForgetPasswordParams params;

  ForgetPasswordEvent({required this.params});

}
class   ForgetPasswordResetEvent extends AuthEvent{
  final ForgetPasswordResetParams params;

  ForgetPasswordResetEvent({required this.params});

}
class   ForgetPasswordVerifyEvent extends AuthEvent{
  final ForgetPasswordVerifyParams params;

  ForgetPasswordVerifyEvent({required this.params});


}
class   LogOutEvent extends AuthEvent{}




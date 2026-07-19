part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserGetMeEvent extends UserEvent {}

class UserUpdateProfileImageEvent extends UserEvent  {
 final UserUpdateProfileImageParams params;

  UserUpdateProfileImageEvent({required this.params});


}

class UserDeleteMeEvent extends UserEvent {}

class UserUpdateMeEvent extends UserEvent {
  final UserUpdateMeParams params;

  UserUpdateMeEvent({required this.params});
}




//ImageProviderHelper

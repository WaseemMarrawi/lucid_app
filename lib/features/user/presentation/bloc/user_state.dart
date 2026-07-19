part of 'user_bloc.dart';

class UserState {
  final DataStateModel<UserResponse?> getMeData;
  final DataStateModel<UserResponse?> postProfileImageData;
  final DataStateModel<UserResponse?> updateMeData;
  final DataStateModel<void> deleteMeData;
  final String? photo;

  UserState({
    this.getMeData = const DataStateModel.setDefultValue(defultValue: null),
    this.postProfileImageData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
    this.updateMeData = const DataStateModel.setDefultValue(defultValue: null),
    this.deleteMeData = const DataStateModel.setDefultValue(defultValue: null),
    this.photo,
  });

  UserState copyWith({
    DataStateModel<UserResponse?>? getMeData,
    DataStateModel<UserResponse?>? postProfileImageData,

    DataStateModel<UserResponse?>? updateMeData,
    DataStateModel<void>? deleteMeData,
    String? photo,
  }) {
    return UserState(
      getMeData: getMeData ?? this.getMeData,
      postProfileImageData: postProfileImageData ?? this.postProfileImageData,
      updateMeData: updateMeData ?? this.updateMeData,
      deleteMeData: deleteMeData ?? this.deleteMeData,
      photo: photo ?? this.photo,
    );
  }
}

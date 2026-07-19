import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../common/helper/src/app_varibles.dart';
import '../../../../common/helper/src/data_state_model.dart';
import '../../../../common/helper/src/helper_func.dart';
import '../../../../common/models/user_model.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/user_model.dart';
import '../../domain/use_cases/user_delete_me_use_cases.dart';
import '../../domain/use_cases/user_get_me_use_cases.dart';
import '../../domain/use_cases/user_update_profile_use_cases.dart';
import '../../domain/use_cases/user_update_me_use_cases.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';

part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserGetMeUseCases _getMeUseCases;
  final UserDeleteMeUseCases _deleteMeUseCases;
  final UserUpdateMeUseCases _updateMeUseCases;
  final UserUpdateProfileImageUseCases _userUpdateProfileImageUseCases;

  UserBloc(
    this._deleteMeUseCases,
    this._getMeUseCases,
    this._userUpdateProfileImageUseCases,
    this._updateMeUseCases,
  ) : super(UserState()) {
    on<UserGetMeEvent>(_getMe);
    on<UserUpdateProfileImageEvent>(_updateProfileImage);
    on<UserDeleteMeEvent>(_deleteMe);
    on<UserUpdateMeEvent>(_updateMe);
  }

  FutureOr<void> _getMe(UserGetMeEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(getMeData: state.getMeData.setLoading()));

    final val = await _getMeUseCases(NoParams());

    val.fold(
      (l) {
        emit(
          state.copyWith(
            getMeData: state.getMeData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(state.copyWith(getMeData: state.getMeData.setSuccess(data: r)));
        AppVariables.user = r.data!;
      },
    );
  }

  FutureOr<void> _deleteMe(
    UserDeleteMeEvent event,
    Emitter<UserState> emit,
  )
  async {
    emit(state.copyWith(deleteMeData: state.deleteMeData.setLoading()));

    final val = await _deleteMeUseCases(NoParams());

    val.fold(
      (l) {
        emit(
          state.copyWith(
            deleteMeData: state.deleteMeData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(state.copyWith(deleteMeData: state.deleteMeData.setSuccess()));
        HelperFunc.logout();
      },
    );
  }

  FutureOr<void> _updateMe(
    UserUpdateMeEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(updateMeData: state.updateMeData.setLoading()));

    final val = await _updateMeUseCases(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            updateMeData: state.updateMeData.setFaild(errorMessage: l.message),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            updateMeData: state.updateMeData.setSuccess(data: r),
            getMeData: state.getMeData.copyWith(data: r),

            // getMeData: state.getMeData.setSuccess(data: r)
          ),
        );

        AppVariables.user = r.data!;

      },
    );
  }

  FutureOr<void> _updateProfileImage(
    UserUpdateProfileImageEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(
      state.copyWith(
        postProfileImageData: state.postProfileImageData.setLoading(),
      ),
    );

    final result = await _userUpdateProfileImageUseCases(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          postProfileImageData: state.postProfileImageData.setFaild(
            errorMessage: l.message,
          ),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            postProfileImageData: state.postProfileImageData.setSuccess(
              data: r,
            ),
            getMeData: state.getMeData.copyWith(
              data: state.getMeData.data!.copyWith(
                data: state.getMeData.data!.data!.copyWith(
                  // profileImage: r.data!.profileImage!,
                ),
              ),
            ),
          ),
        );
        AppVariables.user = r.data!;

      },
    );
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../../common/helper/src/data_state_model.dart';
import '../../data/model/review_response.dart';
import '../../domin/use_cases/review_service_use_case.dart';
import 'package:injectable/injectable.dart';
part 'review_event.dart';

part 'review_state.dart';

@injectable
class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewServiceUseCase _reviewServiceUseCase;

  ReviewBloc( this._reviewServiceUseCase)
    : super(ReviewState()) {
    on<ReviewServiceEvent>(_reviewService);
  }


  FutureOr<void> _reviewService(
    ReviewServiceEvent event,
    Emitter<ReviewState> emit,
  )
  async {
    emit(
      state.copyWith(reviewServiceData: state.reviewServiceData.setLoading()),
    );

    final val = await _reviewServiceUseCase(event.params);

    val.fold(
      (l) {
        emit(
          state.copyWith(
            reviewServiceData: state.reviewServiceData.setFaild(
              errorMessage: l.message,
            ),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            reviewServiceData: state.reviewServiceData.setSuccess(data: r),
          ),
        );
      },
    );
  }
}

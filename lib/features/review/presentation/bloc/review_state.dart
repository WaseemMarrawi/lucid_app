part of 'review_bloc.dart';

class ReviewState {
  final DataStateModel<ReviewResponse?> reviewServiceData;

  ReviewState({

    this.reviewServiceData = const DataStateModel.setDefultValue(
      defultValue: null,
    ),
  });

  ReviewState copyWith({
    DataStateModel<ReviewResponse?>? reviewServiceData,
  }) {
    return ReviewState(
      reviewServiceData: reviewServiceData ?? this.reviewServiceData,
    );
  }
}

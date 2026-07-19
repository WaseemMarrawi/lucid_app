part of 'review_bloc.dart';

sealed class ReviewEvent {}


class ReviewServiceEvent extends ReviewEvent {
  final ReviewServiceParams params;

  ReviewServiceEvent({required this.params});
}


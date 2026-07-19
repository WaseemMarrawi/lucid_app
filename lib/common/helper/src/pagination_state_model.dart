import 'package:flutter/material.dart';

import '../../design/src/widgets.dart';
import '../../enums/enums.dart';

class PaginationStateModel<T> {
  final bool isEndPage;
  final String errorMessage;
  final int perPage;
  final BlocStatus status;
  final List<T> list;

  const PaginationStateModel({
    this.isEndPage = false,
    this.errorMessage = "",
    this.perPage = 1,
    this.status = BlocStatus.init,
    this.list = const [],
  });

  PaginationStateModel<T> copyWith({
    bool? isEndPage,
    String? errorMessage,
    int? perPage,
    BlocStatus? status,
    List<T>? list,
  }) {
    return PaginationStateModel<T>(
      isEndPage: isEndPage ?? this.isEndPage,
      errorMessage: errorMessage ?? this.errorMessage,
      perPage: perPage ?? this.perPage,
      status: status ?? this.status,
      list: list ?? this.list,
    );
  }

  bool get isLoading =>
      (status == BlocStatus.loading || status == BlocStatus.init) &&
      list.isEmpty;

  bool get isFailed => status == BlocStatus.failed && list.isEmpty;

  bool get isEmpty => status == BlocStatus.success && list.isEmpty;

  bool get isSuccess => list.isNotEmpty;

  int get pageNumber => list.length ~/ perPage + 1;

  int get length => list.length;

  int listLength(int over) => list.length + (isEndPage ? 0 : over);

  PaginationStateModel<T> setLoading({required bool isReload}) => copyWith(
        list: isReload ? [] : list,
        status: BlocStatus.loading,
      );

  PaginationStateModel<T> setFaild({required String errorMessage}) => copyWith(
        status: BlocStatus.failed,
        errorMessage: errorMessage,
      );

  PaginationStateModel<T> setSuccess({required List<T> data, int? perPage}) =>
      copyWith(
        list: List.of(list)..addAll(data),
        perPage: perPage,
        isEndPage: data.length < (perPage ?? this.perPage),
        status: BlocStatus.success,
      );

  PaginationStateModel<T> setSuccessReverse({required List<T> data, int? perPage}) =>
      copyWith(
        list: List.of(data)..addAll(list),
        perPage: perPage,
        isEndPage: data.length < (perPage ?? this.perPage),
        status: BlocStatus.success,
      );

  PaginationStateModel<T> resetData() => PaginationStateModel<T>(
        isEndPage: false,
        errorMessage: "",
        perPage: 1,
        status: BlocStatus.init,
        list: [],
      );

  Widget builder({
    Widget? loadingWidget,
    Widget? emptyWidget,
    Widget? failedWidget,
    VoidCallback? onTapRetry,
    required Widget Function() successWidet,
  })
  {
    if (failedWidget == null && onTapRetry == null) {
      throw ArgumentError(
          'Either failed widget or onTapRetry must be provided.');
    }

    if (isSuccess) {
      return successWidet();
    }
    if (isEmpty) {
      return emptyWidget ?? const EmptyDataWidget();
    }
    if (isLoading) {
      return loadingWidget ?? const LoadingWidget();
    } else {
      return failedWidget ??
          AppErrorWidget(
            errorMessage: errorMessage,
            onTap: onTapRetry ?? () {},
          );
    }
  }
  Widget builderSliver({
    Widget? loadingWidget,
    Widget? emptyWidget,
    Widget? failedWidget,
    VoidCallback? onTapRetry,

    required Widget Function() successWidget,
  })
  {
    if (isSuccess) {
      return successWidget();
    }
    if (isEmpty) {
      return emptyWidget ??
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: EmptyDataWidget(),
            ),
          );
    }
    if (isLoading) {
      return loadingWidget ?? const LoadingWidget();
    }
    else {
      return failedWidget ??
          SliverFillRemaining(
            hasScrollBody: false,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppCenterErrorImageWidget(
                subErrorMessage: errorMessage,
                onTapRetry:onTapRetry ,
              ),
            ),
          );
    }
  }
  @override
  String toString() {
    return 'PagenationModel(isEndPage: $isEndPage, errorMessage: $errorMessage, perPage: $perPage, status: $status, list: $list)';
  }

  T operator [](int index) => list[index];

  @override
  bool operator ==(covariant PaginationStateModel<T> other) {
    if (identical(this, other)) return true;

    return other.isEndPage == isEndPage &&
        other.errorMessage == errorMessage &&
        other.perPage == perPage &&
        other.status == status;
  }

  @override
  int get hashCode {
    return isEndPage.hashCode ^
        errorMessage.hashCode ^
        perPage.hashCode ^
        status.hashCode ^
        list.hashCode;
  }
}

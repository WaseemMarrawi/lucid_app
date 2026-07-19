import 'package:flutter/material.dart';

import '../../design/src/widgets.dart';
import '../../enums/enums.dart';

class CachedDataStateModel<T> {

  final BlocStatus status;

  final String errorMessage;

  final T? data;

  final T? defaultValue;

  const CachedDataStateModel({
    this.status = BlocStatus.init,
    this.errorMessage = '',
    this.data,
    this.defaultValue,
  });

  const CachedDataStateModel.setDefaultValue({
    this.status = BlocStatus.init,
    this.errorMessage = '',
    this.defaultValue,
  }) : data = defaultValue;

  bool get isInit =>
      status == BlocStatus.init;

  bool get isLoading =>
      status == BlocStatus.loading ||
          status == BlocStatus.init;

  bool get isFailed =>
      status == BlocStatus.failed;

  bool get isSuccess =>
      status == BlocStatus.success;

  bool get hasData =>
      data != null;

  CachedDataStateModel<T> setLoading() {

    return copyWith(
      status: BlocStatus.loading,
    );
  }

  CachedDataStateModel<T> setFailed({
    required String errorMessage,
  }) {

    return copyWith(
      status: BlocStatus.failed,
      errorMessage: errorMessage,
    );
  }

  CachedDataStateModel<T> setSuccess({
    required T data,
  }) {

    return copyWith(
      status: BlocStatus.success,
      data: data,
      errorMessage: '',
    );
  }

  CachedDataStateModel<T> reset() {

    return CachedDataStateModel<T>(
      status: BlocStatus.init,
      errorMessage: '',
      data: defaultValue,
      defaultValue: defaultValue,
    );
  }

  Widget builder({

    required Widget Function(T data)
    onSuccess,

    Widget? loadingWidget,

    Widget? failedWidget,

    VoidCallback? onTapRetry,

  }) {

    /// إذا يوجد بيانات اعرضها دائمًا
    if (hasData) {

      return onSuccess(data as T);
    }

    /// إذا لا يوجد بيانات و الحالة loading
    if (isLoading) {

      return loadingWidget ??
          const LoadingWidget();
    }

    /// إذا لا يوجد بيانات و الحالة failed
    return failedWidget ??
        AppErrorWidgetReFresh(
          errorMessage: errorMessage,
          onTap: onTapRetry ?? () {},
        );
  }

  CachedDataStateModel<T> copyWith({

    BlocStatus? status,

    String? errorMessage,

    T? data,

  }) {

    return CachedDataStateModel<T>(
      status: status ?? this.status,

      errorMessage:
      errorMessage ?? this.errorMessage,

      data: data ?? this.data,

      defaultValue: defaultValue,
    );
  }

  @override
  String toString() {

    return '''
CachedDataStateModel(
 status: $status,
 errorMessage: $errorMessage,
 hasData: $hasData
)
''';
  }

  @override
  bool operator ==(
      covariant CachedDataStateModel<T> other,
      ) {

    if (identical(this, other)) {
      return true;
    }

    return other.status == status &&
        other.errorMessage == errorMessage &&
        other.data == data;
  }

  @override
  int get hashCode {

    return status.hashCode ^
    errorMessage.hashCode ^
    data.hashCode;
  }
}
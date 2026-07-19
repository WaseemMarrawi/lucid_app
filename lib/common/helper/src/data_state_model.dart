
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design/src/theme/assets.gen.dart';
import '../../design/src/theme/toaster.dart';
import '../../design/src/widgets.dart';
import '../../enums/enums.dart';

class DataStateModel<T> {
  final BlocStatus status;
  final String errorMessage;
  final T data;
  final T _defultValue;

  const DataStateModel({
    this.status = BlocStatus.init,
    this.errorMessage = "",
    required this.data,
    required T defultValue,
  }) : _defultValue = defultValue;

  const DataStateModel.setDefultValue({
    this.status = BlocStatus.init,
    this.errorMessage = "",
    required T defultValue,
  }) : data = defultValue,
       _defultValue = defultValue;

  bool get isInit => status == BlocStatus.init;

  bool get isLoading =>
      status == BlocStatus.loading || status == BlocStatus.init;

  bool get isFailed => status == BlocStatus.failed;

  bool get isSuccess => status == BlocStatus.success;

  DataStateModel<T> setLoading() =>
      copyWith(status: BlocStatus.loading, data: _defultValue);

  DataStateModel<T> setFaild({required String errorMessage}) =>
      copyWith(status: BlocStatus.failed, errorMessage: errorMessage);

  DataStateModel<T> setSuccess({T? data}) =>
      copyWith(data: data, status: BlocStatus.success);

  DataStateModel<T> resetData() => DataStateModel<T>(
    status: BlocStatus.init,
    errorMessage: "",
    data: _defultValue,
    defultValue: _defultValue,
  );

  void listenerFunction({
    VoidCallback? onLoading,
    VoidCallback? onFailed,
    required VoidCallback onSuccess,
  })
  {
    Toaster.closeAllLoading();
    if (status == BlocStatus.loading) {
      Toaster.showLoading();
      onLoading?.call();
    } else if (status == BlocStatus.failed) {
      Toaster.showCustomErrorToast(
        message: errorMessage
      );

      onFailed?.call();
    } else if (status == BlocStatus.success) {
      onSuccess();
    }
  }

  void listenerWithOutLoadingFunction({
    VoidCallback? onLoading,
    VoidCallback? onFailed,
    required VoidCallback onSuccess,
  })
  {
    Toaster.closeAllLoading();
    if (status == BlocStatus.loading) {
    }
    else if (status == BlocStatus.failed) {
      BotToast.showCustomNotification(
        duration: const Duration(seconds: 4),
        toastBuilder: (cancelFunc) {
          return Container(
            margin: const EdgeInsets.only(bottom: 34, right: 20, left: 20),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFB2C36),

              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SvgAsset(Assets.images.svg.signUp.errorIcon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    errorMessage,
                    style: GoogleFonts.alexandria(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    // textDirection: TextDirection.rtl,
                  ),
                ),
                // IconButton(
                //   icon: const Icon(Icons.close, color: Colors.red, size: 20),
                //   onPressed: cancelFunc,
                // )
              ],
            ),
          );
        },
        onlyOne: true,
        align: const Alignment(0, 0.9),
        // أسفل الشاشة
        animationDuration: const Duration(milliseconds: 300),
      );

      onFailed?.call();
    }
    else if (status == BlocStatus.success) {
      onSuccess();
    }
  }

  Widget builder({
    Widget? loadingWidget,
    Widget? failedWidget,
    VoidCallback? onTapRetry,
    required Widget Function(T data) onSuccess,
  })
  {
    if (failedWidget == null && onTapRetry == null) {
      throw ArgumentError(
        'Either failed widget or onTapRetry must be provided.',
      );
    }

    if (isSuccess) {
      return onSuccess(data);
    }
    if (isLoading) {
      return loadingWidget ?? const LoadingWidget();
    } else {
      return failedWidget ??
          AppErrorWidgetReFresh(
            errorMessage: errorMessage,
            onTap: onTapRetry ?? () {},
          );
    }
  }

  @override
  String toString() =>
      'DataStateModel(status: $status, errorMessage: $errorMessage, data: $data)';

  DataStateModel<T> copyWith({
    BlocStatus? status,
    String? errorMessage,
    T? data,
  }) {
    return DataStateModel<T>(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      defultValue: _defultValue,
    );
  }

  @override
  bool operator ==(covariant DataStateModel<T> other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.errorMessage == errorMessage &&
        other.data == data &&
        other._defultValue == _defultValue;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        errorMessage.hashCode ^
        data.hashCode ^
        _defultValue.hashCode;
  }
}

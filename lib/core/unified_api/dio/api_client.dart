import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';

import '../../../common/helper/helper.dart';
import 'logger_interceptor.dart';

// @lazySingleton
// class ApiClient {
//   final LoggerInterceptor loggingInterceptor;
//   late Dio dio;
//
//   ApiClient(
//     Dio dioC, {
//     required this.loggingInterceptor,
//   })
//   {
//     dio = dioC;
//     dio
//       ..options.connectTimeout = const Duration(milliseconds: 30000)
//       ..options.receiveTimeout = const Duration(milliseconds: 30000)
//       ..httpClientAdapter
//       ..options.headers = {
//         'Lang': AppVariables.getCurrentLang(),
//         'Accept': 'application/json',
//         if (HelperFunc.isAuth()) "Authorization": "Bearer ${AppVariables.token}"
//       };
//     dio.interceptors.clear();
//     dio.interceptors.addAll([
//       loggingInterceptor,
//     ]);
//   }
//   resetHeader() {
//     dio.options.headers.clear();
//     dio
//       ..options.connectTimeout = const Duration(milliseconds: 30000)
//       ..options.receiveTimeout = const Duration(milliseconds: 30000)
//       ..httpClientAdapter
//       ..options.headers = {
//         'Lang': AppVariables.getCurrentLang(),
//         'Accept': 'application/json',
//         if (HelperFunc.isAuth()) "Authorization": "Bearer ${AppVariables.token}"
//       };
//     dio.interceptors.add(loggingInterceptor);
//   }
//
//   Future<Response> get(
//     Uri uri, {
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//     data,
//   }) async {
//     return await dio.getUri(
//       uri,
//       data: data,
//       options: options,
//       cancelToken: cancelToken,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   Future<Response> post(Uri uri,
//       {data,
//       Options? options,
//       CancelToken? cancelToken,
//       ProgressCallback? onSendProgress,
//       ProgressCallback? onReceiveProgress}) async {
//     return await dio.postUri(
//       uri,
//       data: data,
//       options: options,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   Future<Response> put(Uri uri,
//       {data,
//       Options? options,
//       CancelToken? cancelToken,
//       ProgressCallback? onSendProgress,
//       ProgressCallback? onReceiveProgress}) async {
//     return await dio.putUri(
//       uri,
//       data: data,
//       options: options,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   Future<Response> patch(Uri uri,
//       {data,
//         Options? options,
//         CancelToken? cancelToken,
//         ProgressCallback? onSendProgress,
//         ProgressCallback? onReceiveProgress}) async {
//     return await dio.patchUri(
//       uri,
//       data: data,
//       options: options,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );
//   }
//
//   Future<Response> delete(
//     Uri uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     return await dio.deleteUri(
//       uri,
//       data: data,
//       options: options,
//       cancelToken: cancelToken,
//     );
//   }
// }

@lazySingleton
class ApiClient {
  final LoggerInterceptor loggingInterceptor;
  late Dio dio;

  ApiClient(Dio dioC, {required this.loggingInterceptor}) {
    dio = dioC;

    dio.httpClientAdapter = IOHttpClientAdapter()
      ..onHttpClientCreate = (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };

    dio.options
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30)
      ..headers = {
        'Lang': AppVariables.getCurrentLang(),
        'Accept': 'application/json',
        if (HelperFunc.isAuth())
          "Authorization": "Bearer ${AppVariables.token}",
      };

    dio.interceptors
      ..clear()
      ..add(loggingInterceptor);
  }

  resetHeader() {
    dio.options.headers.clear();
    dio
      ..options.connectTimeout = const Duration(milliseconds: 30000)
      ..options.receiveTimeout = const Duration(milliseconds: 30000)
      ..httpClientAdapter
      ..options.headers = {
        'Lang': AppVariables.getCurrentLang(),
        'Accept': 'application/json',
        if (HelperFunc.isAuth())
          "Authorization": "Bearer ${AppVariables.token}",
      };
  }

  Future<Response> get(
      Uri uri, {
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        data,
      }) async {
    return await dio.getUri(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post(
      Uri uri, {
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      })
  async {
    return await dio.postUri(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> put(
      Uri uri, {
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await dio.putUri(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> patch(
      Uri uri, {
        data,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await dio.patchUri(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> delete(
      Uri uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    return await dio.deleteUri(
      uri,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../common/helper/helper.dart';
import 'error_handeler.dart';
import 'failure.dart';

mixin HandlingApiManager {
  Future<T> wrapHandlingApi<T>(
      {required Future<Response> Function() tryCall,
      required FromJson<T> jsonConvert,


      })
  async {
    try {
      final  response = await tryCall();
      if (response.statusCode == ResponseCode.SUCCESS ||
          response.statusCode == ResponseCode.NO_CONTENT ||
          response.statusCode == ResponseCode.DELETED) {
        return jsonConvert!(response.data);
      } else {
        throw ServerFailure(
          message: response.data["message"].toString(),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<Either<Failure, T>> wrapHandlingExceptionStream<T>({
    required Stream<T> Function() tryCall,
  }) async* {
    try {
      await for (final item in tryCall()) {
        yield Right(item);
      }
    } catch (e) {
      yield Left(ErrorHandler.handle(e).failure);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_provider.g.dart';

@riverpod
Dio http(HttpRef ref) {
  final options = BaseOptions(
    baseUrl: 'https://purpleplanetpackaging.co.uk/',
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 3000),
    receiveTimeout: const Duration(milliseconds: 3000),
    followRedirects: false,
    maxRedirects: 0,
    validateStatus: (int? status) {
      // return status != null;
      return status != null && status >= 200;
    },
  );

  return Dio(options)
    ..interceptors.addAll([
      ref.watch(dummyInterceptorProvider),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          request: true,
          requestBody: true,
          responseBody: true,
        )
    ]);
}

@riverpod
InterceptorsWrapper dummyInterceptor(DummyInterceptorRef ref) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      // TODO: token interceptor

      handler.next(options);
    },
    onResponse: (options, handler) => handler.next(options),
    onError: (error, handler) => handler.next(error),
  );
}

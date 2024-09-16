import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/cookie_service.dart';

part 'http_provider.g.dart';

@riverpod
Dio http(HttpRef ref) {
  final options = BaseOptions(
    baseUrl: 'https://purpleplanetpackaging.co.uk/',
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    followRedirects: false,
    maxRedirects: 0,
    validateStatus: (int? status) {
      // return status != null;
      return status != null && status >= 200;
    },
  );
  // Future<void> prepareJar() async {
  //   final Directory appDocDir = await getApplicationDocumentsDirectory();
  //   final String appDocPath = appDocDir.path;
  //   final jar = PersistCookieJar(
  //     ignoreExpires: true,
  //     storage: FileStorage(appDocPath + "/.cookies/"),
  //   );

  //   cookieJar.loadForRequest(Uri.parse(options.baseUrl));
  // }
  // void clearCookies() {
  //   _cookieStore.deleteAll();
  // }

  return Dio(options)
    ..interceptors.addAll([
      CookieManager.instance,
      ref.watch(dummyInterceptorProvider),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          // request: true,
          // requestBody: true,
          // responseBody: true,
        )
    ]);
}

// CookieJar prepareJar() {
//   final Directory appDocDir = AppStorage.getAppDocDir();
//   final String appDocPath = appDocDir.path;

//   log(appDocPath, name: 'appDocPath');

//   final jar = PersistCookieJar(
//     ignoreExpires: true,
//     storage: FileStorage("$appDocPath/.cookies/"),
//   );

//   return jar;
// }

@riverpod
InterceptorsWrapper dummyInterceptor(DummyInterceptorRef ref) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      // TODO: token interceptor

      handler.next(options);
    },
    onResponse: (response, handler) {
      handler.next(response);
    },
    onError: (error, handler) => handler.next(error),
  );
}

import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:purple_planet_packaging/app/provider/error_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

import '../core/router/router.dart';
import '../core/utils/app_utils.dart';
import '../services/local/shared_prefs_storage_service.dart';
import 'cocart_interseptor.dart';
import 'shared_preferences_storage_service_provider.dart';

part 'http_provider.g.dart';

Future<CookieJar> initializeCookieJar() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  return PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage('$appDocPath/.cookies/'),
  );
}

Future<void> clearCookies() async {
  final jar = await initializeCookieJar();
  await jar.deleteAll();
}

@riverpod
Future<Dio> http(HttpRef ref) async {
  final options = BaseOptions(
    // baseUrl: 'https://purpleplanetpackaging.co.uk/',
    baseUrl: 'https://staging.purpleplanetpackaging.co.uk/',
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    followRedirects: false,
    maxRedirects: 0,
    validateStatus: (int? status) {
      return status != null && status >= 200;
    },
  );

  final dio = Dio(options);

  final navigatorKey = ref.read(navigatorKeyProvider);
  final cookieJar = await initializeCookieJar();

  dio.interceptors.addAll([
    ErrorInterceptor(navigatorKey),
    CoCartInterceptor(cookieJar),
    CartValidationInterceptor(),
    if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: true,
      ),
  ]);

  return dio;
}

@riverpod
InterceptorsWrapper dummyInterceptor(DummyInterceptorRef ref) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      // TODO: Add token interceptor if needed
      handler.next(options);
    },
    onResponse: (response, handler) {
      handler.next(response);
    },
    onError: (error, handler) => handler.next(error),
  );
}

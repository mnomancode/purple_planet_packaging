import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:purple_planet_packaging/app/provider/error_interceptor.dart';
import 'package:purple_planet_packaging/app/provider/nonce_interseptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

import '../core/router/router.dart';
import '../services/cookie_service.dart';
import 'cocart_interseptor.dart';

part 'http_provider.g.dart';

Future<PersistCookieJar> _prepareJar() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;

  final jar = PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage("$appDocPath/.cookies/"),
  );

  return jar;
}

Future<void> clearCookies() async {
  final cookieJar = await _prepareJar();
  await cookieJar.deleteAll();
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

  final cookieJar = await _prepareJar();
  final navigatorKey = ref.read(navigatorKeyProvider);

  dio.interceptors.addAll([
    // CookieManager(cookieJar),
    ref.watch(dummyInterceptorProvider),
    ErrorInterceptor(navigatorKey),
    CoCartInterceptor(),
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

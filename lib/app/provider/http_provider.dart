import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cookie_jar/cookie_jar.dart';

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

// class CookieManager extends Interceptor {
//   static final CookieManager _instance = CookieManager._internal();

//   factory CookieManager() {
//     return _instance;
//   }

//   CookieManager._internal();

//   List<String>? _cookie;

//   Headers? _headers;
//   var cookieJar = CookieJar();

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (response.headers['set-cookie'] != null) {
//       _cookie = response.headers['set-cookie'];

//       log(_cookie.toString());
//     }

//     cookieJar.loadForRequest(response.requestOptions.uri);

//     super.onResponse(response, handler);
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // options.headers['Cookie'] =
//     //     'wordpress_logged_in_619c11776386cd8d9f640ab73bad5c19=chnoman503%7C1725361902%7CuGb6Sae99G2dkJ8Yq92JG69RqZsDTTpbr6tQYrwOafF%7C4b64f511ef1567ebc5493b165707f31752eb35b0bdc38e5d78bf8a9e00aac66a; wp_woocommerce_session_619c11776386cd8d9f640ab73bad5c19=6003%7C%7C1724325103%7C%7C1724321503%7C%7C6d313287e76dd7bc8195074be35b48a2; woocommerce_items_in_cart=2; woocommerce_cart_hash=a86160c8fdedc3f74eb86ff3e0e9ff03';
//     options.headers['Cookie'] =
//         'wordpress_logged_in_619c11776386cd8d9f640ab73bad5c19=chnoman503%7C1724338865%7CMXqiljH3aBJPp0cli7AcGo5cn5xO2P09DZIE1aWasnf%7C7bce13782fadfec02c3e4dc16d4c73e70029f6d040c1c64b72239c8cd6525185';

//     super.onRequest(options, handler);
//   }
// }

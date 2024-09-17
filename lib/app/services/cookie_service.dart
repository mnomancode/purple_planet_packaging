import 'dart:developer';

import 'package:dio/dio.dart';

class CookieManager extends Interceptor {
  static final CookieManager _instance = CookieManager._internal();

  static CookieManager get instance => _instance;

  CookieManager._internal();
  Headers? myHeaders;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200) {
      return super.onResponse(response, handler);
    }

    myHeaders = response.headers;

    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, String> headers = {};
    myHeaders?.forEach((key, value) {
      headers[key] = value.join(',');
    });

    options.headers.addAll(headers);
    return super.onRequest(options, handler);
  }
}

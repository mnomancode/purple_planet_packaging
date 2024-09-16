import 'dart:developer';

import 'package:dio/dio.dart';

class CookieManager extends Interceptor {
  static final CookieManager _instance = CookieManager._internal();

  static CookieManager get instance => _instance;

  CookieManager._internal();
  String? _cookie;
  Headers? myHeaders;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200) {
      return super.onResponse(response, handler);
    }

    if (response.headers['set-cookie'] != null) {
      _cookie = response.headers['set-cookie']![0];
      myHeaders = response.headers;
    }

    log(response.headers.toString(), name: 'headers');

    log(_cookie ?? '', name: 'cookie');

    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return super.onRequest(options, handler);
  }

  void initCookieManager() {
    _cookie = '';
  }
}

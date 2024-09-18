import 'dart:developer';

import 'package:dio/dio.dart';
import 'header_storage_service.dart';

class CookieManager extends Interceptor {
  static final CookieManager _instance = CookieManager._internal();

  static CookieManager get instance => _instance;

  CookieManager._internal();
  Headers? myHeaders;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != 200) {
      return super.onResponse(response, handler);
    }

    if(response.requestOptions.path.contains('cart')) {
       final headers = response.headers.map.map((key, values) => MapEntry(key, values.join(',')));
       await HeaderStorageService.saveJsonHeaders(headers);
    }
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('cart')) {
      final headers = await HeaderStorageService.getJsonHeaders();
      options.headers.addAll(headers ?? {});
    }

    return super.onRequest(options, handler);
  }
}

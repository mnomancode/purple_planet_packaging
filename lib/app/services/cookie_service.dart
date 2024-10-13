import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'header_storage_service.dart';

class CookieManagerInterceptor extends Interceptor {
  static final CookieManagerInterceptor _instance = CookieManagerInterceptor._internal();

  static CookieManagerInterceptor get instance => _instance;

  CookieManagerInterceptor._internal();
  Headers? myHeaders;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.requestOptions.path.contains('apply-coupon')) return;
      if (response.requestOptions.path.contains('cart')) {
        //Save response cookies into the CookieJar for cart-related responses
        // Uri uri = Uri.parse('${response.requestOptions.baseUrl}/cart');
        List<String>? setCookie = response.headers.map['set-cookie'];
        if (setCookie != null && setCookie.length == 3) {
          List<Cookie> cookies = setCookie.map((str) => Cookie.fromSetCookieValue(str)).toList();
          await HeaderStorageService.saveCookiesToPreferences(cookies);
        }

        final headers = response.headers.map.map((key, values) => MapEntry(key, values.join(',')));
        await HeaderStorageService.saveJsonHeaders(headers);
      }
    }
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('cart')) {
      // Add existing headers if available

      final headers = await HeaderStorageService.getJsonHeaders();

      log(headers.toString(), name: 'headers');
      options.headers.addAll(headers ?? {});

      // Load cookies from SharedPreferences
      List<Cookie>? savedCookies = await HeaderStorageService.loadSavedCookies();

      // If cookies are not found in SharedPreferences, load them from CookieJar
      if (savedCookies != null && savedCookies.isNotEmpty) {
        options.headers['Cookie'] = savedCookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      }
    }

    return super.onRequest(options, handler);
  }
}

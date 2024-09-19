import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import '../provider/http_provider.dart';
import 'header_storage_service.dart';

class CookieManagerInterceptor extends Interceptor {
  static final CookieManagerInterceptor _instance = CookieManagerInterceptor._internal();

  static CookieManagerInterceptor get instance => _instance;

  CookieManagerInterceptor._internal();
  Headers? myHeaders;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != 200) {
      return super.onResponse(response, handler);
    }

    if(response.requestOptions.path.contains('cart')) {

      // Save response cookies into the CookieJar for cart-related responses
      // Uri uri = Uri.parse(response.requestOptions.baseUrl + '/cart');
      // List<String>? setCookie = response.headers.map['set-cookie'];
      // if (setCookie != null) {
      //   List<Cookie> cookies = setCookie.map((str) => Cookie.fromSetCookieValue(str)).toList();
      //   cookieJar.saveFromResponse(uri, cookies);
      // }

       final headers = response.headers.map.map((key, values) => MapEntry(key, values.join(',')));
       await HeaderStorageService.saveJsonHeaders(headers);
    }
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('cart')) {
      // Add existing headers if available
      final headers = await HeaderStorageService.getJsonHeaders();
      options.headers.addAll(headers ?? {});

      // Load cookies from SharedPreferences
      List<Cookie>? savedCookies = await HeaderStorageService.loadSavedCookies();

      // If cookies are not found in SharedPreferences, load them from CookieJar
      if (savedCookies != null && savedCookies.isNotEmpty) {
        options.headers['Cookie'] = savedCookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      } else {
        // Load cookies from the CookieJar for cart-related requests
        List<Cookie> jarCookies = await cookieJar.loadForRequest(Uri.parse('${options.baseUrl}/cart'));
        if (jarCookies.isNotEmpty) {
          await HeaderStorageService.saveCookiesToPreferences(jarCookies);
          options.headers['Cookie'] = jarCookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
        }
      }
    }

    return super.onRequest(options, handler);
  }
}

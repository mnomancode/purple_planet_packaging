import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:fresh_dio/fresh_dio.dart';

import '../services/local/shared_prefs_storage_service.dart';

// class TokenInterceptor extends Interceptor {
//   TokenInterceptor(this.storageService, this.cookieJar);

//   final Dio refreshDio = Dio();
//   final SharedPrefsService storageService;
//   final CookieJar cookieJar;

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     if (response.requestOptions.path.contains('wp-json/jwt-auth/v1')) {
//       final uri = response.requestOptions.uri;
//       final cookies = response.headers.map['set-cookie'];
//       log('Cookies: $cookies');
//       if (cookies != null) {
//         log('Saving cookies for URI: $uri');
//         await cookieJar.saveFromResponse(uri, cookies.map((str) => Cookie.fromSetCookieValue(str)).toList());
//       }
//     }

//     super.onResponse(response, handler);
//   }

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     if (options.path.contains('/wp-json/jwt-auth/v1/token/refresh')) {
//       final uri = Uri.parse('https://staging.purpleplanetpackaging.co.uk/wp-json/jwt-auth/v1/token/refresh');
//       final cookies = await cookieJar.loadForRequest(uri);

//       if (cookies.isNotEmpty) {
//         final cookieHeader = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
//         options.headers['Cookie'] = cookieHeader;
//         storageService.getBearerToken();
//       }
//     }

//     super.onRequest(options, handler);
//   }
// }

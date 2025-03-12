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
    if (response.statusCode == 403) {
      // Attempt to refresh nonce or session if we hit 403
      log('403 Forbidden - Attempting to refresh session...');
      await _refreshSession();
      return handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      ));
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.requestOptions.path.contains('apply-coupon')) return;

      if (response.requestOptions.path.contains('cart')) {
        List<String>? setCookie = response.headers.map['set-cookie'];
        if (setCookie != null) {
          List<Cookie> cookies = setCookie.map((str) => Cookie.fromSetCookieValue(str)).toList();
          await HeaderStorageService.saveCookiesToPreferences(cookies);
        }

        final headers = response.headers.map.map(
          (key, values) => MapEntry(key, values.join(',')),
        );

        await HeaderStorageService.saveJsonHeaders(headers);
        log('✅ Saved headers: $headers');
      }
    }

    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('cart') || options.path.contains('v1')) {
      final headers = await HeaderStorageService.getJsonHeaders();

      if (headers != null) {
        log('🔹 Loaded headers: $headers');
        options.headers.addAll(headers);
      }

      // Load cookies from SharedPreferences
      List<Cookie>? savedCookies = await HeaderStorageService.loadSavedCookies();
      if (savedCookies != null && savedCookies.isNotEmpty) {
        options.headers['Cookie'] = savedCookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      }

      // Add authorization token if available
      final token = await HeaderStorageService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      // Ensure nonce is present, if not -> refresh session
      if (!_containsNonce(options.headers)) {
        await _refreshSession();
        final refreshedHeaders = await HeaderStorageService.getJsonHeaders();
        if (refreshedHeaders != null) {
          options.headers.addAll(refreshedHeaders);
        }
      }
    }

    return super.onRequest(options, handler);
  }

  Future<void> _refreshSession() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://purpleplanetpackaging.co.uk/wp-json/wc/store/v1/cart',
      );

      if (response.statusCode == 200) {
        final newHeaders = response.headers.map.map(
          (key, value) => MapEntry(key, value.join(',')),
        );

        await HeaderStorageService.saveJsonHeaders(newHeaders);

        List<String>? setCookie = response.headers.map['set-cookie'];
        if (setCookie != null) {
          List<Cookie> cookies = setCookie.map((str) => Cookie.fromSetCookieValue(str)).toList();
          await HeaderStorageService.saveCookiesToPreferences(cookies);
        }

        log('✅ Session refreshed with new nonce and cookies');
      }
    } catch (e) {
      log('🚨 Failed to refresh session: $e');
    }
  }

  bool _containsNonce(Map<String, dynamic> headers) {
    return headers['X-WP-Nonce'] != null;
  }
}

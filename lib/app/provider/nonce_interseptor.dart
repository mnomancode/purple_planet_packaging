import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NonceInterceptor extends Interceptor {
  static final NonceInterceptor _instance = NonceInterceptor._internal();

  static NonceInterceptor get instance => _instance;

  Headers? myHeaders;

  NonceInterceptor._internal();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (myHeaders == null) {
      await _loadHeaders();
    }

    if (myHeaders != null) {
      options.headers.addAll(myHeaders!.map);
    }

    // Refresh nonce only if it's a cart or v1 request and nonce is missing
    if ((options.path.contains('/cart') || options.path.contains('/v1')) && (myHeaders == null || !_containsNonce())) {
      await refreshHeaders();

      if (myHeaders != null) {
        options.headers.addAll(myHeaders!.map);
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && err.response?.data['code'] == 'woocommerce_rest_missing_nonce') {
      print('Invalid nonce. Refreshing...');

      await refreshHeaders();

      if (myHeaders != null) {
        // Retry the request with updated headers
        err.requestOptions.headers.addAll(myHeaders!.map);
        final response = await Dio().fetch(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }

    handler.next(err);
  }

  Future<void> _loadHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final headersString = prefs.getString('woocommerce_headers');

    if (headersString != null) {
      final headersMap = Map<String, dynamic>.from(json.decode(headersString));
      myHeaders = Headers.fromMap(
        headersMap.map((key, value) => MapEntry(key, List<String>.from(value))),
      );
      print('Loaded headers: $myHeaders');
    }
  }

  Future<void> refreshHeaders() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://purpleplanetpackaging.co.uk/wp-json/wc/store/v1/cart',
      );

      if (response.statusCode == 200) {
        final newHeaders = response.headers.map.map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        );

        myHeaders = Headers.fromMap(newHeaders);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('woocommerce_headers', json.encode(newHeaders));

        print('New headers stored: $newHeaders');
      }
    } catch (e) {
      print('Failed to refresh headers: $e');
    }
  }

  bool _containsNonce() {
    return myHeaders?.value('X-WP-Nonce') != null;
  }
}

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class CookieInterceptor extends Interceptor {
  late PersistCookieJar _cookieJar;

  CookieInterceptor() {
    _initCookieJar();
  }

  Future<void> _initCookieJar() async {
    final dir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage("${dir.path}/.cookies/"),
    );
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Only attach cookies if the URL contains 'cocart'
    if (options.path.contains('cocart')) {
      final cookies = await _cookieJar.loadForRequest(options.uri);
      String cookieHeader = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      if (cookieHeader.isNotEmpty) {
        options.headers['Cookie'] = cookieHeader;
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Only save cookies if the URL contains 'cocart'
    if (response.requestOptions.path.contains('cocart')) {
      await _cookieJar.saveFromResponse(
        response.requestOptions.uri,
        (response.headers['set-cookie'] ?? []).map((header) {
          return Cookie.fromSetCookieValue(header);
        }).toList(),
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

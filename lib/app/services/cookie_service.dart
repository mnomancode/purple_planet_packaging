import 'dart:convert';
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

    options.headers.forEach((key, value) {
      if (headers.keys.contains('date')) {
        headers['date'] = value.join('GMT');
      } else {
        headers[key] = value.join(',');
      }
    });

    Map<String, dynamic> headersT = convertHeaderStringToMap(myHeaders.toString());

    options.headers.addAll(headers);
    return super.onRequest(options, handler);
  }
}

Map<String, dynamic> convertHeaderStringToMap(String headerString) {
  // Remove outer curly braces
  headerString = headerString.replaceAll(RegExp(r'^\{|\}$'), '');

  // Split into key-value pairs, ensuring we don't split values with dots or tokens
  List<String> headerList = headerString.split(RegExp(r', (?=\w+:)'));

  // Create a map by splitting key and value
  Map<String, dynamic> headerMap = {};
  for (var item in headerList) {
    var keyValue = item.split(': ');

    // Handle token and any other values with multiple colon splits correctly
    var key = keyValue[0].trim();
    var value = keyValue.sublist(1).join(': ').trim(); // Handles the case with colons in the value (e.g., the token)

    // Try to parse JSON-like values if possible
    if (value.startsWith('{') && value.endsWith('}')) {
      try {
        value = json.decode(value);
      } catch (e) {
        // If decoding fails, leave the value as a string
      }
    }

    headerMap[key] = value;
  }

  return headerMap;
}

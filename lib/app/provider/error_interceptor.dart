import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  final GlobalKey<NavigatorState> navigatorKey;

  ErrorInterceptor(this.navigatorKey);

  BuildContext? get context => navigatorKey.currentContext;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(err.response?.data.toString() ?? 'errrr');

    if (err.response?.statusCode == 401 && context != null) {
      // Show snackbar
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          content: Text('Session expired. Please log in again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
    handler.next(err);
  }
}

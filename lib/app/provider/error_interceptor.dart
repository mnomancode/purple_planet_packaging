import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  final GlobalKey<NavigatorState> navigatorKey;

  ErrorInterceptor(this.navigatorKey);

  BuildContext? get context => navigatorKey.currentContext;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 404) {
      // show snackbar
      final message = response.data['message'];
      final snackBar = SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        clipBehavior: Clip.antiAlias,
        hitTestBehavior: HitTestBehavior.opaque,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            context?.pop();
          },
        ),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }

    handler.next(response);
  }
}

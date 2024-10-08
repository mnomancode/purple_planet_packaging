import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUtils {
  AppUtils._();

  static isTablet(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.size.shortestSide > 600;
  }

  static String get getAuthorizationHeader =>
      'Basic ${base64Encode(utf8.encode('${dotenv.get('CONSUMERKEY')}:${dotenv.get('CONSUMERSECRET')}'))}';
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class HeaderStorageService {
  static Future<void> saveJsonHeaders(Map<String, dynamic> headers) async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the map (which can contain arrays and nested objects) to a JSON string
    String headersJson = jsonEncode(headers);
    await prefs.setString('headers', headersJson);
  }

  static Future<Map<String, dynamic>?> getJsonHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    String? headersJson = prefs.getString('headers');

    if (headersJson != null) {
      // Decode JSON string back into a Map<String, dynamic> to handle complex structures
      Map<String, dynamic> decodedHeaders = jsonDecode(headersJson);
      return decodedHeaders;
    }

    return null;
  }

  // Clear headers
  static Future<void> clearHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('headers');
  }


  /// Save cookies to SharedPreferences
  static Future<void> saveCookiesToPreferences(List<Cookie> cookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookieString = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
    await prefs.setString('cart_cookies', cookieString);
  }

  /// Load cookies from SharedPreferences
  static Future<List<Cookie>?> loadSavedCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cookieString = prefs.getString('cart_cookies');
    if (cookieString != null) {
      return cookieString.split('; ').map((cookieStr) {
        var parts = cookieStr.split('=');
        return Cookie(parts[0].trim(), parts[1].trim());
      }).toList();
    }
    return null;
  }
}

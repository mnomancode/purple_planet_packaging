import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  // ignore: unused_field
  late SharedPreferences sharedPreferences;

  static AppStorage? instance;

  static AppStorage getInstance() => instance ??= AppStorage();

  /// for initialling app local storage
  Future<void> initAppStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (!kIsWeb) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      putString('appDocDir', appDocPath);
      log(appDocPath, name: 'appDocPath');
    }
  }

  Future<void> putString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  String saveCartKey(String cartKey) {
    log(cartKey, name: 'cartKey Saving');
    sharedPreferences.setString('cart_key', cartKey);
    return cartKey;
  }

  Future<String?> getCartKey() async {
    log('getCartKey', name: 'getCartKey');
    return sharedPreferences.getString('cart_key');
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await sharedPreferences.clear();
  }
}

final appStorageProvider = Provider<AppStorage>(
  (_) {
    return AppStorage.getInstance();
  },
);

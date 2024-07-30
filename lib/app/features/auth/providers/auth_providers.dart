import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController with ChangeNotifier {
//Within this section, you can integrate authentication methods
//such as Firebase, SharedPreferences, and more.

  bool isLoggedIn = false;

  void signIn() {
    isLoggedIn = true;

    notifyListeners();
  }

  void signOut() {
    isLoggedIn = false;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthController());

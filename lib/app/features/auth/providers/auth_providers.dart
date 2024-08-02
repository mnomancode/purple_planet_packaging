import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController with ChangeNotifier {
// TODO: Implement the AuthController class. This class will be used to manage the state of the authentication process.

  bool isLoggedIn = false;
  bool isRegistering = false;

  void signIn() {
    isLoggedIn = true;

    notifyListeners();
  }

  void signOut() {
    isLoggedIn = false;
    notifyListeners();
  }

  void register() {
    isRegistering = !isRegistering;

    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthController());

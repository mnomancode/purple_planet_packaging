import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController with ChangeNotifier {
  bool isLoggedIn = false;
  bool isRegistering = false;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  updateLoading([bool value = false]) {
    isLoading = value;
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthController());

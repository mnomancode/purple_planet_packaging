import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_providers.dart';
import 'package:purple_planet_packaging/app/features/home/view/home_view.dart';
import 'package:purple_planet_packaging/app/features/main/view/main_view.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthView'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(authProvider.notifier).signIn();
            context.go(HomeView.routeName);
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}

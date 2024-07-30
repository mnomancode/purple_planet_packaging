import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_providers.dart';
import 'package:purple_planet_packaging/app/features/auth/view/auth_view.dart';
import 'package:purple_planet_packaging/app/features/splash/view/splash_view.dart';

import '../../features/main/view/main_view.dart';

///
/// for getting routers that are present in the app
///
///
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

// GoRouter.of(_rootNavigatorKey.currentContext!).go('/a'))
final routerProvider = Provider<GoRouter>(
  (ref) {
    // final bool loggedIn = ref.watch(authProvider).isLoggedIn;
    final authState = ref.watch(authProvider);

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashView.routeName,
      // refreshListenable: authState,
      redirect: (context, state) {
        /**
      * Your Redirection Logic Code  Here..........
      */
        final isAuthenticated = authState.isLoggedIn;

        /// [state.fullPath] will give current  route Path

        if (state.fullPath == AuthView.routeName) {
          return isAuthenticated ? null : AuthView.routeName;
        }

        /// null redirects to Initial Location

        return isAuthenticated ? null : SplashView.routeName;
      },
      routes: [
        GoRoute(
          path: SplashView.routeName,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: AuthView.routeName,
          builder: (context, state) => const AuthView(),
        ),
        GoRoute(
          path: DashboardView.routeName,
          builder: (context, state) => const DashboardView(),
        ),
      ],
    );
  },
);

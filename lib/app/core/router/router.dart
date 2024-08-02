import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_providers.dart';
import 'package:purple_planet_packaging/app/features/auth/view/auth_view.dart';
import 'package:purple_planet_packaging/app/features/auth/view/lost_pass_view.dart';
import 'package:purple_planet_packaging/app/features/cart/view/cart_view.dart';
import 'package:purple_planet_packaging/app/features/home/view/home_view.dart';
import 'package:purple_planet_packaging/app/features/profile/view/profile_view.dart';
import 'package:purple_planet_packaging/app/features/shop/view/shop_view.dart';
import 'package:purple_planet_packaging/app/features/splash/view/splash_view.dart';

import '../../features/main/view/dashboard_view.dart';

///
/// for getting routers that are present in the app
///
///
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

// GoRouter.of(_rootNavigatorKey.currentContext!).go('/a'))
final routerProvider = Provider<GoRouter>(
  (ref) {
    // final bool loggedIn = ref.watch(authProvider).isLoggedIn;
    final authState = ref.watch(authProvider);

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: HomeView.routeName,
      refreshListenable: authState,
      redirect: (context, state) {
        if (kDebugMode) return null;

        /**
      * Your Redirection Logic Code  Here..........
      */
        final isAuthenticated = authState.isLoggedIn;

        /// [state.fullPath] will give current  route Path
        ///
        ///

        if (state.fullPath == AuthView.routeName) {
          return isAuthenticated ? null : AuthView.routeName;
        }
        if (state.fullPath!.contains(LostView.routeName)) {
          return null;
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
          routes: [
            GoRoute(name: LostView.routeName, path: LostView.routeName, builder: (context, state) => const LostView()),
          ],
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
            return DashboardView(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: _sectionANavigatorKey,
              routes: [
                GoRoute(
                  path: HomeView.routeName,
                  builder: (context, state) => const HomeView(),
                  routes: const [],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ShopView.routeName,
                  builder: (context, state) => const ShopView(),
                  routes: const [],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: CartView.routeName,
                  builder: (context, state) => const CartView(),
                  routes: const [],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ProfileView.routeName,
                  builder: (context, state) => const ProfileView(),
                  routes: const [],
                ),
              ],
            ),
          ],
        )
      ],
    );
  },
);

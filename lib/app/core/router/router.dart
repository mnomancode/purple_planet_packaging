import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/address/view/billing_address_view.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_state_notifier.dart';
import 'package:purple_planet_packaging/app/features/auth/view/auth_view.dart';
import 'package:purple_planet_packaging/app/features/auth/view/lost_pass_view.dart';
import 'package:purple_planet_packaging/app/features/cart/view/cart_view.dart';
import 'package:purple_planet_packaging/app/features/custom_print/view/faqs_view.dart';
import 'package:purple_planet_packaging/app/features/home/view/home_view.dart';
import 'package:purple_planet_packaging/app/features/order_samples/view/order_samples_view.dart';
import 'package:purple_planet_packaging/app/features/profile/view/about_us_view.dart';
import 'package:purple_planet_packaging/app/features/profile/view/profile_view.dart';
import 'package:purple_planet_packaging/app/features/shop/view/shop_view.dart';
import 'package:purple_planet_packaging/app/features/splash/view/splash_view.dart';
import 'package:purple_planet_packaging/app/features/custom_print/view/get_started_view.dart';

import '../../commons/loading/loading_screen.dart';
import '../../features/address/view/shipping_address_view.dart';
import '../../features/custom_print/view/custom_print_view.dart';
import '../../features/featured_products/view/featured_products_view.dart';
import '../../features/main/view/dashboard_view.dart';
import '../../features/orders/views/order_completed.dart';
import '../../features/profile/view/contact_us_view.dart';
import '../../features/shop/view/product_details/product_details_view.dart';
import '../../features/shop/view/products_view.dart';
import '../../models/products/product.dart';
import '../../provider/is_loading_provider.dart';

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
    // final authState = ref.watch(authStateNotifierProvider);

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: SplashView.routeName,
      // refreshListenable: authState,
      // redirect: (context, state) {
      //   if (kDebugMode) return null;

      //   /**
      // * Your Redirection Logic Code  Here..........
      // */
      //   final isAuthenticated = authState.isLoggedIn;

      //   /// [state.fullPath] will give current  route Path
      //   ///
      //   ///

      //   if (state.fullPath == AuthView.routeName) {
      //     return isAuthenticated ? null : AuthView.routeName;
      //   }
      //   if (state.fullPath!.contains(LostView.routeName)) {
      //     return null;
      //   }

      //   /// null redirects to Initial Location

      //   return isAuthenticated ? null : SplashView.routeName;
      // },
      routes: [
        GoRoute(
          path: SplashView.routeName,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          path: AuthView.routeName,
          builder: (context, state) => Consumer(builder: (context, ref, child) {
            ref.listen<bool>(
              isLoadingProvider,
              (_, isLoading) {
                if (isLoading) {
                  LoadingScreen.instance().show(
                    context: context,
                  );
                } else {
                  LoadingScreen.instance().hide();
                }
              },
            );

            return const AuthView();
          }),
          routes: [
            GoRoute(name: LostView.routeName, path: LostView.routeName, builder: (context, state) => const LostView()),
          ],
        ),
        GoRoute(
          path: FeaturedProductsView.routeName,
          name: FeaturedProductsView.routeName,
          builder: (context, state) => const FeaturedProductsView(),
        ),
        GoRoute(
          name: ProductDetailsView.routeName,
          path: '${ProductDetailsView.routeName}/:title',
          builder: (context, state) {
            final title = state.pathParameters['title'] ?? 'Error${state.uri.queryParameters['title']}';
            // final productId = state.uri.queryParameters['productId'] ?? '0000';
            final product = state.extra as Product;
            return ProductDetailsView(title: title, product: product);
          },
        ),
        GoRoute(
            path: OrderSamplesView.routeName,
            name: OrderSamplesView.routeName,
            builder: (context, state) => const OrderSamplesView()),
        GoRoute(
          path: AddressView.routeName,
          name: AddressView.routeName,
          builder: (context, state) {
            final isShipping = state.uri.queryParameters['isShipping'] == 'true';
            return AddressView(isShipping);
          },
        ),
        GoRoute(
          path: BillingAddressView.routeName,
          name: BillingAddressView.routeName,
          builder: (context, state) {
            return const BillingAddressView(false);
          },
        ),
        GoRoute(
            name: CustomPrintView.routeName,
            path: CustomPrintView.routeName,
            builder: (context, state) => const CustomPrintView(),
            routes: [
              GoRoute(
                  name: GetStarted.routeName,
                  path: GetStarted.routeName,
                  builder: (context, state) => const GetStarted()),
              GoRoute(
                  name: FaqsView.routeName, path: FaqsView.routeName, builder: (context, state) => const FaqsView()),
            ]),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
            return Consumer(builder: (context, ref, child) {
              ref.listen<bool>(
                isLoadingProvider,
                (_, isLoading) {
                  if (isLoading) {
                    LoadingScreen.instance().show(
                      context: context,
                    );
                  } else {
                    LoadingScreen.instance().hide();
                  }
                },
              );

              return DashboardView(navigationShell: navigationShell);
            });
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: _sectionANavigatorKey,
              routes: [
                GoRoute(
                  path: HomeView.routeName,
                  name: HomeView.routeName,
                  builder: (context, state) => const HomeView(),
                  routes: [],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: ShopView.routeName,
                  path: ShopView.routeName,
                  builder: (context, state) => const ShopView(),
                  routes: [
                    GoRoute(
                      name: ProductsView.routeName,
                      path: ProductsView.routeName,
                      builder: (context, state) {
                        final title =
                            state.uri.queryParameters['title'] ?? 'Error  OP ${state.uri.queryParameters['title']}';
                        final categoryId = state.uri.queryParameters['categoryId'] ?? '0000';
                        final term = state.uri.queryParameters['term'];
                        return ProductsView(pageTitle: title, categoryId: categoryId, term: term);
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: CartView.routeName,
                  builder: (context, state) => const CartView(),
                  routes: [
                    GoRoute(
                      name: OrderCompleteView.routeName,
                      path: OrderCompleteView.routeName,
                      builder: (context, state) => const OrderCompleteView(),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: ProfileView.routeName,
                  builder: (context, state) => const ProfileView(),
                  routes: [
                    GoRoute(
                      name: AboutUsView.routeName,
                      path: AboutUsView.routeName,
                      builder: (context, state) => const AboutUsView(),
                    ),
                    GoRoute(
                      name: ContactUsView.routeName,
                      path: ContactUsView.routeName,
                      builder: (context, state) => const ContactUsView(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  },
);

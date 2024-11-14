import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/cart/cart_model.dart';
import '../../../models/orders/order_body.dart';
import '../../notifications/notification_controller.dart';
import '../repository/cart_repository_impl.dart';
import '../view/cart_view.dart';

part 'cart_notifier.g.dart';

@riverpod
class NewCartNotifier extends _$NewCartNotifier {
  final Set<int> _loadingItems = {};

  @override
  FutureOr<Cart> build() {
    // this is like init method as in getx Controller
    return ref.watch(cartRepositoryProvider).getCart('');
  }

  Future<void> getCart() async {
    final tempState = await ref.watch(cartRepositoryProvider).getCart('');

    state = AsyncValue.data(tempState);
  }

  Future<void> addToCart(
      {required int productId, int quantity = 1, required BuildContext context, bool notify = true}) async {
    await ref.read(notificationControllerProvider.notifier).scheduleNotification(
          'Your Items are waiting!',
          'Are you sure you want to leave this behind?',
          DateTime.now().add(const Duration(days: 5)),
          payload: '/home/cart',
        );

    _loadingItems.add(productId);
    state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));

    final tempState = await ref.watch(cartRepositoryProvider).addToCart(productId, quantity: quantity);

    if (notify) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getQuantity(productId) == 0 ? 'Item added to cart successfully!' : 'Item updated successfully!',
            style: AppStyles.mediumStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () => context.go(CartView.routeName),
        ),
      ));
    }

    _loadingItems.remove(productId);
    state = AsyncValue.data(tempState.copyWith(loadingItems: _loadingItems.toList()));
  }

  getQuantity(int id) {
    try {
      return state.value?.items.firstWhere((element) => element.id == id).quantity ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> updateItem({required String itemKey, required int quantity}) async {
    if (quantity == 0) {
      final tempState = await ref.watch(cartRepositoryProvider).removeItem(itemKey);

      state = AsyncValue.data(tempState);
    } else {
      final item = state.value!.items.firstWhere((element) => element.key == itemKey);
      _loadingItems.add(item.id);
      state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));

      final tempState = await ref.watch(cartRepositoryProvider).updateItem(itemKey, quantity: quantity);

      _loadingItems.remove(item.id);
      state = AsyncValue.data(tempState.copyWith(loadingItems: _loadingItems.toList()));
    }
  }

  removeItem({required String itemKey, int quantity = 1}) async {
    final tempState = await ref.watch(cartRepositoryProvider).removeItem(itemKey);

    state = AsyncValue.data(tempState);
  }

  Future<void> applyCoupon({required String code}) async {
    final tempState = await ref.watch(cartRepositoryProvider).applyCoupon(code);

    state = AsyncValue.data(tempState);
  }

  bool isItemLoading(int id) {
    return _loadingItems.contains(id);
  }

  List<LineItem>? getLineItems() {
    return state.value?.items.map((e) {
      return LineItem(productId: e.id, quantity: e.quantity, variationId: 0);
    }).toList();
  }

  List<String> getKeys() {
    return state.value?.items.map((e) {
          return e.key;
        }).toList() ??
        [];
  }

  Future<void> clearCart() async {
    var tempState = await Future.wait(getKeys().map((e) => ref.watch(cartRepositoryProvider).removeItem(e)));
    await ref.read(notificationControllerProvider.notifier).cancelAllNotifications();
    for (var element in tempState) {
      if (element.itemsCount == 0) {
        state = AsyncValue.data(element);
      }
    }
  }
}

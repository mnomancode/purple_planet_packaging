import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/models/products/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/cart/cart_model.dart';
import '../../../models/orders/order_body.dart';
import '../../../provider/shared_preferences_storage_service_provider.dart';
import '../../notifications/notification_controller.dart';
import '../../orders/notifiers/orders_notifier.dart';
import '../repository/cart_repository_impl.dart';
import '../view/cart_view.dart';
import 'selected_shipping_provider.dart';

part 'cart_notifier.g.dart';

@riverpod
class NewCartNotifier extends _$NewCartNotifier {
  final Set<int> _loadingItems = {};

  @override
  FutureOr<Cart> build() {
    return getCart();
  }

  Future<Cart> getCart() async {
    final tempState = await ref.watch(cartRepositoryProvider).getCart();

    state = AsyncValue.data(tempState);
    ref
        .read(selectedShippingMethodNotifierProvider.notifier)
        .setSelectedShippingMethod(tempState.shipping.selectedRate);

    return tempState;
  }

  int getDefaultProductId(Product product) {
    if (product.defaultAttributes?.isEmpty ?? true) {
      return product.id;
    }

    final String? defaultOption = product.defaultAttributes?.first.option;
    final List<String>? options = product.attributes.first.options;

    if (defaultOption == null || options == null || options.isEmpty) {
      return product.id;
    }

    final int index = options.indexOf(defaultOption);
    if (index == -1 || index >= product.variations.length) {
      return product.id;
    }

    return product.variations[index];
  }

  Future<void> addToCart({
    required BuildContext context,
    required int productId,
    bool notify = true,
    int quantity = 1,
  }) async {
    try {
      if (notify) {
        ref.read(orderScreenLoadingNotifierProvider.notifier).setLoading(true);
      } else {
        _loadingItems.add(productId);
        state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));
      }

      final tempState = await ref.watch(cartRepositoryProvider).addToCart(productId, quantity: quantity);

      state = AsyncValue.data(tempState);
      if (notify) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getQuantity(productId) == 0 ? 'Item added to cart successfully!' : 'Item updated successfully!',
              style: AppStyles.mediumStyle(color: Colors.white)),
          backgroundColor: AppColors.primaryColor,
          action: SnackBarAction(
              label: 'View Cart', textColor: Colors.white, onPressed: () => context.go(CartView.routeName)),
        ));
      }
    } catch (e) {
      log(e.toString());
    } finally {
      if (notify) {
        ref.read(orderScreenLoadingNotifierProvider.notifier).setLoading(false);
      } else {
        _loadingItems.remove(productId);
        state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));
      }
    }
  }

  getQuantity(int id) {
    try {
      return state.value?.items?.firstWhere((element) => element.id == id).quantity ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> updateItem({required String itemKey, required int quantity, int? id}) async {
    if (id != null) {
      _loadingItems.add(id);
    }

    if (quantity == 0) {
      final tempState = await ref.watch(cartRepositoryProvider).removeItem(itemKey);

      state = AsyncValue.data(tempState);
    } else {
      state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));

      final tempState = await ref.watch(cartRepositoryProvider).updateItem(itemKey, quantity: quantity);

      _loadingItems.remove(id);
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
    return state.value?.items?.map((e) {
      return LineItem(productId: e.id, quantity: e.quantity.value, variationId: 0);
    }).toList();
  }

  List<String> getKeys() {
    return state.value?.items?.map((e) {
          return e.itemKey;
        }).toList() ??
        [];
  }

  Future<void> clearCart() async {
    var tempState = await Future.wait(getKeys().map((e) => ref.watch(cartRepositoryProvider).removeItem(e)));
    await ref.read(notificationControllerProvider.notifier).cancelAllNotifications();
    for (var element in tempState) {
      if (element.itemCount == 0) {
        state = AsyncValue.data(element);
      }
    }
  }
}

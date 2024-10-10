import 'dart:developer';

import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/model/shipping_methods.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/cart/new_cart_model.dart';
import '../repository/cart_repository_impl.dart';
import 'shipping_meathods_notifier.dart';

part 'cart_notifier.g.dart';

@riverpod
class NewCartNotifier extends _$NewCartNotifier {
  final Set<int> _loadingItems = {};

  @override
  FutureOr<NewCartModel> build() {
    // this is like init method as in getx Controller
    return ref.watch(cartRepositoryProvider).getCart('');
  }

  Future<void> getCart() async {
    final tempState = await ref.watch(cartRepositoryProvider).getCart('');

    state = AsyncValue.data(tempState);
  }

  Future<void> addToCart({required int productId, int quantity = 1}) async {
    _loadingItems.add(productId);
    state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));

    final tempState = await ref.watch(cartRepositoryProvider).addToCart(productId, quantity: quantity);

    _loadingItems.remove(productId);
    state = AsyncValue.data(tempState.copyWith(loadingItems: _loadingItems.toList()));
  }

  getQuantity(int id) {
    return state.value?.items?.firstWhere((element) => element.id == id).quantity;
  }

  Future<void> updateItem({required String itemKey, required int quantity}) async {
    if (quantity == 0) {
      final tempState = await ref.watch(cartRepositoryProvider).removeItem(itemKey);

      state = AsyncValue.data(tempState);
    } else {
      final item = state.value!.items!.firstWhere((element) => element.key == itemKey);
      _loadingItems.add(item.id!);
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

  bool isItemLoading(int id) {
    return _loadingItems.contains(id);
  }

  int getTotalQuantity() {
    return state.value?.items?.fold(0, (previousValue, element) => (previousValue ?? 0) + (element.quantity ?? 0)) ?? 0;
  }

  double? getSubTotal() {
    String d =
        (state.value?.cartTotals?.totalPrice?.addDecimalFromEnd(state.value?.cartTotals?.currencyMinorUnit) ?? 0.0)
            .toString()
            .addShippingCharge(AppUtils.getShippingCost(ref.read(selectedShippingMethodNotifierProvider)) ?? 0.0)
            .addTwentyPercent();

    log(d, name: 'd');

    return double.tryParse(d);
  }

  // '£ ${data.cartTotals?.totalPrice?.addDecimalFromEnd(data.cartTotals?.currencyMinorUnit)?.addShippingCharge(AppUtils.getShippingCost(ref.watch(selectedShippingMethodNotifierProvider)) ?? 0.0) ?? '0.00'}',
}

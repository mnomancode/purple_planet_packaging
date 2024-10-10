import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/shipping_methods.dart';
import '../repository/cart_repository_impl.dart';

part 'shipping_meathods_notifier.g.dart';

@riverpod
class ShippingMethodsNotifier extends _$ShippingMethodsNotifier {
  @override
  FutureOr<List<ShippingMethod>> build() {
    return getShippingMethod();
  }

  FutureOr<List<ShippingMethod>> getShippingMethod() async {
    var res = await ref.watch(cartRepositoryProvider).getShippingMethod();
    state = AsyncData(res);

    return ref.watch(cartRepositoryProvider).getShippingMethod();
  }

  double? getShippingCost(ShippingMethod shippingMethod) {
    int quantity = ref.watch(newCartNotifierProvider.notifier).getTotalQuantity();
    return AppUtils.getShippingCost(shippingMethod, quantity: quantity);
  }
}

@riverpod
class SelectedShippingMethodNotifier extends _$SelectedShippingMethodNotifier {
  @override
  ShippingMethod? build() {
    return null;
  }

  void setSelectedShippingMethod(ShippingMethod? method) {
    state = method;
  }

  void clearSelectedShippingMethod() {
    state = null;
  }

  double? getShippingCost() {
    int quantity = ref.watch(newCartNotifierProvider.notifier).getTotalQuantity();

    return AppUtils.getShippingCost(state, quantity: quantity);
  }
}

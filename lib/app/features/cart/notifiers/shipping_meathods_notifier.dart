import 'dart:developer';

import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/models/cart/cart_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/orders/order_body.dart';
import '../model/shipping_methods.dart';
import '../repository/cart_repository_impl.dart';

part 'shipping_meathods_notifier.g.dart';

@Riverpod(keepAlive: true)
class ShippingMethodsNotifier extends _$ShippingMethodsNotifier {
  @override
  FutureOr<List<ShippingMethod>> build() {
    return getShippingMethod();
  }

  FutureOr<List<ShippingMethod>> getShippingMethod() async {
    var res = await ref.read(cartRepositoryProvider).getShippingMethod();
    state = AsyncData(res);

    return ref.read(cartRepositoryProvider).getShippingMethod();
  }

  double? getShippingCost(ShippingMethod shippingMethod) {
    int quantity = ref.read(newCartNotifierProvider.notifier).getTotalQuantity();
    return AppUtils.getShippingCost(shippingMethod, quantity: quantity);
  }
}

@Riverpod(keepAlive: true)
class SelectedShippingMethodNotifier extends _$SelectedShippingMethodNotifier {
  @override
  ShippingRate? build() {
    return null;
  }

  void setSelectedShippingMethod(ShippingRate? method) {
    state = method;
  }

  void clearSelectedShippingMethod() {
    state = null;
  }

  List<ShippingLine> getShippingLines() {
    return [
      ShippingLine(
        methodId: state?.methodId ?? '',
        methodTitle: state?.name ?? '',
        total: state?.formattedPrice ?? '',
      ),
    ];
  }

  // double? getShippingCost() {
  //   int quantity = ref.read(newCartNotifierProvider.notifier).getTotalQuantity();

  //   return AppUtils.getShippingCost(state, quantity: quantity);
  // }

  // List<ShippingLine> getShippingLines() {
  //   return [
  //     ShippingLine(
  //       methodId: state?.methodId ?? '',
  //       methodTitle: state?.title ?? '',
  //       total: getShippingCost().toString(),
  //     ),
  //   ];
  // }
}

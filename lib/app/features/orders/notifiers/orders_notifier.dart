import 'dart:developer';

import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/shipping_meathods_notifier.dart';
import 'package:purple_planet_packaging/app/models/orders/order_body.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/orders/order.dart';
import '../repository/orders_repository_impl.dart';

part 'orders_notifier.g.dart';

@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  List<Order> build() {
    return [];
  }

  // new order
  Future<void> newOrder() async {
    List<LineItem>? lineItems = ref.read(newCartNotifierProvider.notifier).getLineItems();

    if (lineItems == null) return;

    log(lineItems.toString(), name: 'line items');

    List<ShippingLine> shippingLine = ref.read(selectedShippingMethodNotifierProvider.notifier).getShippingLines();

    OrderBody orderBody = OrderBody(
      billing: billing,
      shipping: shipping,
      shippingLines: shippingLine,
      lineItems: lineItems,
      paymentMethod: 'cod',
      paymentMethodTitle: 'COD',
      setPaid: false,
    );

    log(orderBody.toString(), name: 'order body');

    Order ord = await ref.read(ordersRepositoryProvider).newOrder(orderBody);
    // TODO : add a stripe code here
    // if true set payment to true
    await ref.read(ordersRepositoryProvider).completePayment(ord.id).then(
      (value) {
        state = [...state, ord];
      },
    );
  }
}

Shipping shipping = Shipping(
  firstName: 'test',
  lastName: 'test',
  address1: 'test',
  address2: 'test',
  city: 'test',
  state: 'test',
  postcode: 'test',
  country: 'test',
);

Billing billing = Billing(
  firstName: 'test',
  lastName: 'test',
  address1: 'test',
  address2: 'test',
  city: 'test',
  state: 'test',
  postcode: 'test',
  country: 'test',
  email: 'test@gmail.com',
  phone: 'test',
);

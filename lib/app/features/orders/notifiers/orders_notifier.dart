import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/features/address/providers/notifier/address_notifier.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/shipping_meathods_notifier.dart';
import 'package:purple_planet_packaging/app/features/splash/view/splash_view.dart';
import 'package:purple_planet_packaging/app/models/orders/order_body.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/orders/order.dart';
import '../../../services/stripe_service.dart';
import '../../address/view/shipping_address_view.dart';
import '../repository/orders_repository_impl.dart';
import '../views/order_completed.dart';

part 'orders_notifier.g.dart';

@riverpod
class OrderScreenLoadingNotifier extends _$OrderScreenLoadingNotifier {
  @override
  bool build() {
    return false;
  }

  void toggleLoading() {
    state = !state;
  }

  void setLoading(bool value) {
    state = value;
  }
}

@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  List<Order> build() {
    return [];
  }

  // new order
  Future<void> newOrder(BuildContext context) async {
    try {
      ref.read(orderScreenLoadingNotifierProvider.notifier).setLoading(true);

      List<LineItem>? lineItems = ref.read(newCartNotifierProvider.notifier).getLineItems();

      if (lineItems == null) return;

      List<ShippingLine> shippingLine = ref.read(selectedShippingMethodNotifierProvider.notifier).getShippingLines();
      Billing? billing = await ref.read(billingNotifierProvider.notifier).build();
      Shipping? shipping = await ref.read(shippingNotifierProvider.notifier).build();

      if (shipping == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Shipping address not found'),
            action: SnackBarAction(
              label: 'Add New +',
              onPressed: () {
                context.pushNamed(AddressView.routeName);
              },
            ),
          ),
        );
        return;
      }

      OrderBody orderBody = OrderBody(
        billing: billing ?? dummyBilling,
        shipping: shipping,
        shippingLines: shippingLine,
        lineItems: lineItems,
        paymentMethod: 'stripe',
        paymentMethodTitle: 'Stripe',
        setPaid: false,
      );

      String? customerId = await StripeService.createCustomer('Guest@gmail.com', shipping);
      if (customerId != null) {
        Order ord = await ref.read(ordersRepositoryProvider).newOrder(orderBody);

        Map<String, dynamic>? paymentIntent = await StripeService.initPaymentSheet(
          amount: int.parse((ord.total.replaceAll('.', ''))),
          customerId: customerId,
          orderId: '${ord.id}',
          billing: shipping,
          context: context,
        );

        ref.read(orderScreenLoadingNotifierProvider.notifier).setLoading(true);

        if (paymentIntent != null) {
          await Future.wait([
            ref.read(ordersRepositoryProvider).completePayment(ord.id, paymentIntent['id']),
            ref.watch(newCartNotifierProvider.notifier).clearCart()
          ]);
        }
        context.goNamed(OrderCompleteView.routeName);
        Navigator.of(context).pop();
      } else {}
    } catch (e) {
      log(e.toString());
    } finally {
      ref.read(orderScreenLoadingNotifierProvider.notifier).setLoading(false);
    }
  }
}

Shipping dummyShipping = Shipping(
  firstName: 'test',
  lastName: 'test',
  address1: 'test',
  address2: 'test',
  city: 'test',
  state: 'test',
  postcode: 'test',
  country: 'test',
);

Billing dummyBilling = Billing(
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

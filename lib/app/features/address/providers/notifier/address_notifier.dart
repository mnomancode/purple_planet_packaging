import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:purple_planet_packaging/app/features/orders/notifiers/orders_notifier.dart';
import 'package:purple_planet_packaging/app/models/orders/order_body.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../provider/shared_preferences_storage_service_provider.dart';

part 'address_notifier.g.dart';

@riverpod
class ShippingNotifier extends _$ShippingNotifier {
  @override
  Future<Shipping?> build() async {
    final shipping = await ref.read(storageServiceProvider).get('shipping');
    if (shipping == null) return null;
    state = AsyncData(Shipping.fromJson(json.decode(shipping.toString())));

    return state.value;
  }

  void updateField(String field, String value) {
    if (state.value == null) {
      state = AsyncData(Shipping.empty());
    }

    switch (field) {
      case 'firstName':
        state = AsyncData(state.value?.copyWith(firstName: value));
        break;
      case 'lastName':
        state = AsyncData(state.value?.copyWith(lastName: value));
        break;
      case 'address1':
        state = AsyncData(state.value?.copyWith(address1: value));
        break;
      case 'address2':
        state = AsyncData(state.value?.copyWith(address2: value));
        break;
      case 'city':
        state = AsyncData(state.value?.copyWith(city: value));
        break;
      case 'state':
        state = AsyncData(state.value?.copyWith(state: value));
        break;
      case 'postcode':
        state = AsyncData(state.value?.copyWith(postcode: value));
        break;
      case 'country':
        state = AsyncData(state.value?.copyWith(country: value));
        break;
    }
  }

  void saveShipping(BuildContext context) {
    ref.read(storageServiceProvider).set('shipping', json.encode(state.value!.toJson()));
    Navigator.of(context).pop();
  }
}

@riverpod
class BillingNotifier extends _$BillingNotifier {
  @override
  Future<Billing?> build() async {
    final billing = await ref.read(storageServiceProvider).get('billing');
    if (billing == null) return null;

    final email = await ref.read(storageServiceProvider).getEmail();
    state = AsyncData(Billing.fromJson(json.decode(billing.toString())).copyWith(email: email ?? "Guest@gmail.com"));
    return state.value;
  }

  void saveBilling(BuildContext context) {
    ref.read(storageServiceProvider).set('billing', json.encode(state.value!.toJson()));
    Navigator.of(context).pop();
  }

  updateField(String s, String value) {
    if (state.value == null) {
      state = AsyncData(Billing.empty());
    }

    switch (s) {
      case 'firstName':
        state = AsyncData(state.value?.copyWith(firstName: value));
        break;
      case 'lastName':
        state = AsyncData(state.value?.copyWith(lastName: value));
        break;
      case 'address1':
        state = AsyncData(state.value?.copyWith(address1: value));
        break;
      case 'address2':
        state = AsyncData(state.value?.copyWith(address2: value));
        break;
      case 'city':
        state = AsyncData(state.value?.copyWith(city: value));
        break;
      case 'state':
        state = AsyncData(state.value?.copyWith(state: value));
        break;
      case 'postcode':
        state = AsyncData(state.value?.copyWith(postcode: value));
        break;
      case 'country':
        state = AsyncData(state.value?.copyWith(country: value));
        break;
    }
  }
}

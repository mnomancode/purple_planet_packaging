import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/cart/model/shipping_methods.dart';

class AppUtils {
  AppUtils._();

  static isTablet(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.size.shortestSide > 600;
  }

  static String get getAuthorizationHeader =>
      'Basic ${base64Encode(utf8.encode('${dotenv.get('CONSUMERKEY')}:${dotenv.get('CONSUMERSECRET')}'))}';

  static double? getShippingCost(ShippingMethod? shippingMethod, {int quantity = 1}) {
    if (shippingMethod == null) {
      return null;
    }
    if (shippingMethod.settings.cost == null) {
      return null;
    }

    if (shippingMethod.settings.cost!.value != null) {
      return _calculatePrice(quantity, shippingMethod.settings.cost!.value!);
    }

    return null;
  }

  static double _calculatePrice(int qty, String priceString) {
    // Replace [qty] with the actual quantity
    String replaced = priceString.replaceAll('[qty]', qty.toString());

    // Split the string by '*' to separate the price and quantity
    List<String> parts = replaced.split('*');

    // Parse the price and quantity as doubles
    double price = double.parse(parts[0]);
    double quantity = double.parse(parts[1]);

    // Perform the multiplication and return the result
    return price * quantity;
  }
}

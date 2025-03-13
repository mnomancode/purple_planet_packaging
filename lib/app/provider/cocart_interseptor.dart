import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoCartInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('cocart')) {
      final cartKey = await getCartKey();

      log('Trying to get cart key: $cartKey');

      if (cartKey != null) {
        options.queryParameters['cart_key'] = cartKey;
      }
    }
    handler.next(options);
    handler.next(options);
  }

  /// Get cart key
  Future<String?> getCartKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cart_key');
  }

  /// Save cart key
  Future<void> saveCartKey(String cartKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart_key', cartKey);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (response.data != null && response.data['cart_key'] != null) {
        log('Saving cart key: ${response.data['cart_key']}');
        await saveCartKey(response.data['cart_key']);
      }
    } catch (e) {
      log('Failed to save cart key: $e');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Error occurred: ${err.message}');
    handler.next(err);
  }
}

class CartValidationInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Response dummyResponse = response;

    try {
      if (response.data['cart_hash'] == "No items in cart so no hash") {
        log('No items in the cart.', name: 'No items in the cart.');

        response.data = {
          "cart_hash": "No items in cart so no hash",
          "cart_key": "null",
          "currency": {
            "currency_code": "GBP",
            "currency_symbol": "£",
            "currency_symbol_pos": "currency_prefix",
            "currency_minor_unit": 2,
            "currency_decimal_separator": ".",
            "currency_thousand_separator": ",",
            "currency_prefix": "£",
            "currency_suffix": ""
          },
          "customer": {
            "billing_address": {
              "billing_email": "",
              "billing_phone": "",
              "invoice_email": "",
              "billing_first_name": "",
              "billing_last_name": "",
              "billing_country": "GB",
              "billing_company": "",
              "billing_address_1": "",
              "billing_address_2": "",
              "billing_postcode": "",
              "billing_gazchaps_getaddress_io_postcode_lookup_button": "",
              "billing_gazchaps_getaddress_io_enter_address_manually_button": "",
              "billing_state": "",
              "kl_newsletter_checkbox": "",
              "tracking_id": "",
              "billing_company_display": "",
              "company_id": "",
              "purchase_order_number": "",
              "billing_city": ""
            },
            "shipping_address": {
              "shipping_first_name": "",
              "shipping_last_name": "",
              "shipping_company": "",
              "shipping_address_1": "",
              "shipping_address_2": "",
              "shipping_postcode": "",
              "shipping_gazchaps_getaddress_io_postcode_lookup_button": "",
              "shipping_gazchaps_getaddress_io_enter_address_manually_button": "",
              "shipping_city": "",
              "shipping_state": "",
              "shipping_country": "GB"
            }
          },
          "items": [],
          "item_count": 0,
          "items_weight": "0",
          "coupons": [],
          "needs_payment": false,
          "needs_shipping": false,
          "shipping": {
            "total_packages": 1,
            "show_package_details": false,
            "has_calculated_shipping": false,
            "packages": {
              "default": {
                "package_name": "Shipping",
                "rates": {
                  "table_rate:4": {
                    "key": "table_rate:4",
                    "method_id": "table_rate",
                    "instance_id": 4,
                    "label": "*Standard Delivery",
                    "cost": "795",
                    "html": "*Standard Delivery: £7.95",
                    "taxes": "159",
                    "chosen_method": true,
                    "meta_data": {
                      "items":
                          "Planetware™ 16oz Double Wall Takeaway Christmas Cup 2024, Recyclable/Compostable (Case of 500) × 1"
                    }
                  },
                  "flat_rate:6": {
                    "key": "flat_rate:6",
                    "method_id": "flat_rate",
                    "instance_id": 6,
                    "label": "*Next Working Day - Pre noon £15.00/Item",
                    "cost": "1500",
                    "html": "*Next Working Day - Pre noon £15.00/Item: £15.00",
                    "taxes": "300",
                    "chosen_method": false,
                    "meta_data": {
                      "items":
                          "Planetware™ 16oz Double Wall Takeaway Christmas Cup 2024, Recyclable/Compostable (Case of 500) × 1"
                    }
                  },
                  "flat_rate:7": {
                    "key": "flat_rate:7",
                    "method_id": "flat_rate",
                    "instance_id": 7,
                    "label": "*Next Working Day - Pre 10am £25.00/Item",
                    "cost": "2500",
                    "html": "*Next Working Day - Pre 10am £25.00/Item: £25.00",
                    "taxes": "500",
                    "chosen_method": false,
                    "meta_data": {
                      "items":
                          "Planetware™ 16oz Double Wall Takeaway Christmas Cup 2024, Recyclable/Compostable (Case of 500) × 1"
                    }
                  },
                  "flat_rate:8": {
                    "key": "flat_rate:8",
                    "method_id": "flat_rate",
                    "instance_id": 8,
                    "label": "*Saturday Delivery £15.00/item",
                    "cost": "1500",
                    "html": "*Saturday Delivery £15.00/item: £15.00",
                    "taxes": "300",
                    "chosen_method": false,
                    "meta_data": {
                      "items":
                          "Planetware™ 16oz Double Wall Takeaway Christmas Cup 2024, Recyclable/Compostable (Case of 500) × 1"
                    }
                  }
                },
                "package_details": "",
                "index": 0,
                "chosen_method": "table_rate:4",
                "formatted_destination": ""
              }
            }
          },
          "fees": [],
          "taxes": [],
          "totals": {
            "subtotal": "0",
            "subtotal_tax": "0",
            "fee_total": "0",
            "fee_tax": "0",
            "discount_total": "0",
            "discount_tax": "0",
            "shipping_total": "0",
            "shipping_tax": "0",
            "total": "0",
            "total_tax": "0"
          },
          "removed_items": [
            {
              "item_key": "f1daf122cde863010844459363cd31db",
              "id": 5892,
              "name": "Planetware™ 16oz Double Wall Takeaway Christmas Cup 2024"
            }
          ]
        };

        throw EmptyCartException('No items in the cart.');
      }
    } catch (e) {
      log('Failed to validate cart: $e');
    }
    handler.next(dummyResponse);
  }
}

class EmptyCartException implements Exception {
  final String message;
  EmptyCartException(this.message);

  @override
  String toString() => message;
}

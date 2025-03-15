import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:cookie_jar/cookie_jar.dart';

class CoCartInterceptor extends Interceptor {
  final CookieJar cookieJar;

  CoCartInterceptor(this.cookieJar);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('cocart')) {
      final cookies = await cookieJar.loadForRequest(Uri.parse(options.baseUrl));
      if (cookies.isNotEmpty) {
        String cookieHeader = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
        options.headers['Cookie'] = cookieHeader;
        log('Attached cookies: $cookieHeader');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.path.contains('cocart')) {
      // Save cookies from response
      final uri = Uri.parse(response.requestOptions.baseUrl);
      if (response.headers['set-cookie'] != null) {
        final cookies = response.headers['set-cookie']!.map((cookie) => Cookie.fromSetCookieValue(cookie)).toList();
        await cookieJar.saveFromResponse(uri, cookies);
        log('Saved cookies: ${cookies.map((c) => c.toString()).join('; ')}');
      }
    }

    handler.next(response);
  }
}

class CartValidationInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Response dummyResponse = response;

    try {
      if (response.data['cart_hash'] == "No items in cart so no hash") {
        log('No items in the cart.', name: 'No items in the cart.');

        final cartKey = response.data['cart_key'];

        response.data = {
          "cart_hash": "No items in cart so no hash",
          "cart_key": cartKey,
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
                    "meta_data": {}
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
                    "meta_data": {}
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
                    "meta_data": {}
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
                    "meta_data": {}
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
          "removed_items": []
        };

        dummyResponse = response;
      }
    } catch (e) {
      if (e is EmptyCartException) {
        throw EmptyCartException(e.message);
      }

      if (e is AuthenticationException) {
        throw AuthenticationException(e.message);
      } else {
        log(e.toString(), name: 'CoCartInterceptor');
      }
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

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

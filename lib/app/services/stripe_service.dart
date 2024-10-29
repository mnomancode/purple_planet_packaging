import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../features/orders/repository/orders_repository_impl.dart';

// class StripeService {
//
//   static const String _baseUrl = 'https://api.stripe.com/v1/';
//   static const String _apiKey = 'sk_test_51L81KRGVx2o8VJLu3seRDMg0cTOWIidbT3fwlTYRpN3kGQW1V47h6SxKvJDbGNAMV6qHhIvU4hYXgorr0EOziOVL00ewYm0xuH'; // Replace with your actual secret key
//
//   static const String customers = "customers";
//   static const String paymentIntents = "payment_intents";
//   static const String refunds = "refunds";
//
//   static Future<String?> createCustomer(String email) async {
//     try {
//       // Prepare the headers and body
//       final headers = {
//         'Authorization': 'Bearer $_apiKey',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       };
//       final body = {
//         'email': email,
//       };
//
//       // Send POST request
//       final response = await http.post(
//         Uri.parse('$_baseUrl$customers'),
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         // Parse the response body to get the customer ID
//         final data = json.decode(response.body);
//         return data['id'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//
//   static initPaymentSheet ({required int amount, required String customerId}) async {
//    try {
//      Map<String, dynamic>? paymentIntent = await createPaymentIntent(amount, 'USD');
//
//      if (paymentIntent != null) {
//        await Stripe.instance.initPaymentSheet(
//          paymentSheetParameters: SetupPaymentSheetParameters(
//            paymentIntentClientSecret: paymentIntent['client_secret'],
//            merchantDisplayName: 'Purple Planet',
//            customerId: customerId,
//            applePay: const PaymentSheetApplePay(
//              merchantCountryCode: 'US',
//            ),
//            googlePay: const PaymentSheetGooglePay(
//              currencyCode: 'USD',
//              merchantCountryCode: 'US',
//            ),
//            //customerEphemeralKeySecret: ephemeralKey,
//            style: ThemeMode.dark,
//          ),
//        );
//        await Stripe.instance.presentPaymentSheet();
//      }
//    } catch (e) {
//      log('Error');
//    }
//   }
//
//   static Future<Map<String, dynamic>?> createPaymentIntent(int amount, String currency) async {
//
//     try {
//       // Request headers
//       final headers = {
//         'Authorization': 'Bearer $_apiKey',
//         'Content-Type': 'application/x-www-form-urlencoded',
//       };
//
//       // Request body
//       final body = {
//         'amount': amount.toString(),
//         'currency': currency,
//       };
//
//       // Make POST request to Stripe
//       final response = await http.post(
//         Uri.parse('$_baseUrl$paymentIntents'),
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         print('Failed to create payment intent: ${response.reasonPhrase}');
//         return null;
//       }
//     } catch (err) {
//       throw Exception('Error creating payment intent: $err');
//     }
//   }
//
//   static Future<bool> createRefund(String paymentIntentId, int amount) async {
//     final Map<String, String> headers = {
//       'Authorization': 'Bearer $_apiKey', // Replace with actual secret key
//       'Content-Type': 'application/x-www-form-urlencoded',
//     };
//
//     final Map<String, String> body = {
//       'payment_intent': paymentIntentId,
//       'amount': amount.toString(),
//     };
//
//     try {
//       final http.Response response = await http.post(
//         Uri.parse('$_baseUrl$refunds'),
//         headers: headers,
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         print('Refund successful: ${json.decode(response.body)}');
//         return true;
//       } else {
//         print('Refund failed: ${response.reasonPhrase}');
//         print('Response body: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error creating refund: $e');
//       return false;
//     }
//   }
// }

class StripeService {
  static const String _baseUrl = 'https://api.stripe.com/v1/';
  static const String _apiKey = 'sk_test_2WwHnEIgdlvlUGWKxd86Koog00oTzdnKLK';
  // static const String _apiKey =
  //     'sk_test_51L81KRGVx2o8VJLu3seRDMg0cTOWIidbT3fwlTYRpN3kGQW1V47h6SxKvJDbGNAMV6qHhIvU4hYXgorr0EOziOVL00ewYm0xuH'; // Replace with actual secret key

  static const String customers = "customers";
  static const String paymentIntents = "payment_intents";
  static const String refunds = "refunds";

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  ));

  static Future<String?> createCustomer(String email) async {
    try {
      final response = await _dio.post(
        customers,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['id'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error creating customer: $e');
      return null;
    }
  }

  static Future<bool> initPaymentSheet({required int amount, required String customerId, BuildContext? context}) async {
    try {
      Map<String, dynamic>? paymentIntent = await createPaymentIntent(amount, 'GBP');

      if (paymentIntent != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: const BillingDetails(
              name: 'Purple Planet',
              email: '8Dm9l@example.com',
              phone: '+48888000888',
            ),
            paymentIntentClientSecret: paymentIntent['client_secret'],
            merchantDisplayName: 'Purple Planet',
            customerId: customerId,
            applePay: const PaymentSheetApplePay(
              merchantCountryCode: 'US',
            ),
            googlePay: const PaymentSheetGooglePay(
              currencyCode: 'USD',
              merchantCountryCode: 'US',
            ),
            style: ThemeMode.dark,
          ),
        );
        await Stripe.instance.presentPaymentSheet();
        return true;

        /// After Payment Success
        /// Call place order api or according to yours requirement
        ///
        /// If you make an api call and it gives error then
        /// call refund api here. Because order is not successfully placed
        /// so we will return money.
        ///
        /// await createRefund(paymentIntent['id'],amount);
      }
    } on StripeException catch (e) {
      log('Error initializing payment sheet: ${e.error}');
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text('${e.error.localizedMessage}'),
        ),
      );

      return false;
    } catch (e) {
      print('Error initializing payment sheet: $e');
      // snackbar localoze message
      // StripeException(error: LocalizedErrorMessage(code: FailureCode.Canceled, localizedMessage: The payment has been canceled, message: The payment has been canceled, stripeErrorCode: null, declineCode: null, type: null))

      if (context != null) {}

      return false;

      /// Payment Fail
    }

    return false;
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(int amount, String currency) async {
    try {
      final response = await _dio.post(
        paymentIntents,
        data: {
          'amount': amount.toString(),
          'currency': currency,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Failed to create payment intent: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Error creating payment intent: $e');
      return null;
    }
  }

  static Future<bool> createRefund(String paymentIntentId, int amount) async {
    try {
      final response = await _dio.post(
        refunds,
        data: {
          'payment_intent': paymentIntentId,
          'amount': amount.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Refund successful: ${response.data}');
        return true;
      } else {
        print('Refund failed: ${response.statusMessage}');
        return false;
      }
    } catch (e) {
      print('Error creating refund: $e');
      return false;
    }
  }

  Future<void> startGooglePay(BuildContext context) async {
    final googlePaySupported =
        await Stripe.instance.isPlatformPaySupported(googlePay: const IsGooglePaySupportedParams());
    if (googlePaySupported) {
      try {
        // 1. fetch Intent Client Secret from backend
        Map<String, dynamic>? paymentIntent = await createPaymentIntent(1000, 'USD');

        if (paymentIntent == null) {
          return;
        }

        final clientSecret = paymentIntent['client_secret'];
        // 2.present google pay sheet
        await Stripe.instance.confirmPlatformPayPaymentIntent(
            clientSecret: clientSecret,
            confirmParams: const PlatformPayConfirmParams.googlePay(
              googlePay: GooglePayParams(
                testEnv: true,
                merchantName: 'Example Merchant Name',
                merchantCountryCode: 'Es',
                currencyCode: 'PK',
              ),
            )
            // PresentGooglePayParams(clientSecret: clientSecret),
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Pay payment succesfully completed')),
        );
      } catch (e) {
        if (e is StripeException) {
          log('Error during google pay', error: e.error, stackTrace: StackTrace.current);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.error}')),
          );
        } else {
          log('Error during google pay', error: e, stackTrace: (e as Error?)?.stackTrace);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google pay is not supported on this device')),
      );
    }
  }
}

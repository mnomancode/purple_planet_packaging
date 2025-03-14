import 'dart:developer';

import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/provider/shared_preferences_storage_service_provider.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/cart/cart_model.dart';
import '../../../provider/http_provider.dart';
import '../../../services/local/shared_prefs_storage_service.dart';
import '../../../services/service.dart';
import '../model/shipping_methods.dart';
import 'cart_repository.dart';

part 'cart_repository_impl.g.dart';

class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl({required CartService cartService, required this.sharedPrefsService}) : _cartService = cartService;
  final CartService _cartService;
  final SharedPrefsService sharedPrefsService;

  @override
  Future<Cart> getCart() async {
    Cart response;
    final token = sharedPrefsService.getBearerToken();
    final cartKey = sharedPrefsService.getCartKey();

    log(token.toString(), name: 'token');
    log(cartKey.toString(), name: 'cartKey');

    if (token != null) {
      response = await _cartService.getCart(token: token);
    } else if (cartKey != null) {
      response = await _cartService.getCartWithKey(cartKey);
    } else {
      response = await _cartService.getCart();
      await saveCartKey(response.cartKey);
    }

    return response;
  }

  saveCartKey(String cartKey) async {
    await sharedPrefsService.set('cart_key', cartKey);
  }

  @override
  Future<HttpResponse> login() {
    return _cartService.login();
  }

  @override
  Future<Cart> addToCart(int productId, {int quantity = 1}) async {
    Future<Cart> response;
    final token = sharedPrefsService.getBearerToken();
    final cartKey = sharedPrefsService.getCartKey();

    final body = AddCartBody(id: '$productId', quantity: '$quantity');

    if (token != null) {
      response = _cartService.addToCart(body, token: token);
    } else if (cartKey != null) {
      response = _cartService.addToCartWithKey(body, cartKey);
    } else {
      response = getCart();
    }

    return response;
  }

  @override
  Future<Cart> updateItem(String itemKey, {required int quantity}) {
    final token = sharedPrefsService.getBearerToken();
    final cartKey = sharedPrefsService.getCartKey();

    return _cartService.updateItem(itemKey, quantity: quantity, token: token, cartKey: cartKey);
  }

  @override
  Future<Cart> removeItem(String itemKey) {
    final token = sharedPrefsService.getBearerToken();
    final cartKey = sharedPrefsService.getCartKey();

    return _cartService.removeItem(itemKey, token: token, cartKey: cartKey);
  }

  @override
  Future<List<ShippingMethod>> getShippingMethod() {
    return _cartService.getShippingMethod(AppUtils.getAuthorizationHeader);
  }

  @override
  Future<Cart> applyCoupon(String code) {
    return _cartService.applyCoupon(AppUtils.getAuthorizationHeader, code);
  }

  @override
  Future<Cart> clearCart(List<String> keys) {
    return _cartService.removeMultipleItems(keys);
  }
}

@riverpod
CartRepository cartRepository(CartRepositoryRef ref) {
  final http = ref.watch(httpProvider).value;

  if (http == null) {
    throw Exception('HTTP client is not initialized yet');
  }
  final storageProvider = ref.watch(storageServiceProvider);

  return CartRepositoryImpl(cartService: CartService(http), sharedPrefsService: storageProvider);
}

class AddCartBody {
  AddCartBody({
    required this.id,
    required this.quantity,
  });

  final String id;
  final String quantity;
  // from json
  factory AddCartBody.fromJson(Map<String, dynamic> json) => AddCartBody(
        id: json["id"],
        quantity: json["quantity"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}

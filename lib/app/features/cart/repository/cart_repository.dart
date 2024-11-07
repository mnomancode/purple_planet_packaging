import 'package:purple_planet_packaging/app/models/cart/cart_model.dart';

import '../model/shipping_methods.dart';

abstract class CartRepository {
  // bool isBasketExpanded = false;

  // void toggleBasket();

  Map<String, dynamic>? responseHeaders;

  Future<Cart> getCart(String cartToken);

  Future<Cart> addToCart(int productId, {int quantity = 1});

  Future<Cart> updateItem(String itemKey, {required int quantity});
  Future<Cart> removeItem(String itemKey);
  Future<Cart> applyCoupon(String code);
  Future<Cart> clearCart(List<String> keys);

  Future<List<ShippingMethod>> getShippingMethod();
}

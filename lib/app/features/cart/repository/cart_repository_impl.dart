import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/cart/cart_model.dart';
import '../../../provider/http_provider.dart';
import '../../../services/service.dart';
import '../model/shipping_methods.dart';
import 'cart_repository.dart';

part 'cart_repository_impl.g.dart';

class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl({required CartService cartService}) : _cartService = cartService;
  final CartService _cartService;

  @override
  Future<Cart> getCart(String cartToken) async {
    final response = await _cartService.getCart();

    return response;
  }

  @override
  Future<Cart> addToCart(int productId, {int quantity = 1}) {
    return _cartService.addToCart(productId, quantity: quantity);
  }

  @override
  Future<Cart> updateItem(String itemKey, {required int quantity}) {
    return _cartService.updateItem(itemKey, quantity: quantity);
  }

  @override
  Future<Cart> removeItem(String itemKey) {
    return _cartService.removeItem(itemKey);
  }

  @override
  Future<List<ShippingMethod>> getShippingMethod() {
    return _cartService.getShippingMethod(AppUtils.getAuthorizationHeader);
  }

  @override
  Future<Cart> applyCoupon(String code) {
    return _cartService.applyCoupon(AppUtils.getAuthorizationHeader, code);
  }
}

@riverpod
CartRepository cartRepository(CartRepositoryRef ref) {
  final http = ref.watch(httpProvider);

  return CartRepositoryImpl(cartService: CartService(http));
}

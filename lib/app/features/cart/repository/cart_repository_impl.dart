import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  // @override
  // void toggleBasket() {
  //   isBasketExpanded = !isBasketExpanded;
  //   log('isBasketExpanded: $isBasketExpanded');
  //   notifyListeners();
  // }
}

final cartRepositoryProvider = ChangeNotifierProvider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  // TODO add your methods here
}

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

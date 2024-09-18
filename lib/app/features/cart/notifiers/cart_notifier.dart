import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/cart/new_cart_model.dart';
import '../repository/cart_repository_impl.dart';

part 'cart_notifier.g.dart';

@riverpod
class NewCartNotifier extends _$NewCartNotifier {
  @override
  FutureOr<NewCartModel> build() {
    // this is like init method as in getx Controller
    return ref.watch(cartRepositoryProvider).getCart('');
  }

  Future<void> getCart() async {
    final tempState = await ref.watch(cartRepositoryProvider).getCart('');

    state = AsyncValue.data(tempState);
  }

  Future<void> addToCart({required int productId, int quantity = 1}) async {
    final tempState = await ref.watch(cartRepositoryProvider).addToCart(productId, quantity: quantity);

    state = AsyncValue.data(tempState);

    // TODO : uncomment if you need to hit the build meathod again Not needed now
    // ref.invalidateSelf();
  }
}

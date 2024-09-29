import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/cart/new_cart_model.dart';
import '../repository/cart_repository_impl.dart';

part 'cart_notifier.g.dart';

@riverpod
class NewCartNotifier extends _$NewCartNotifier {
  final Set<int> _loadingItems = {};

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
    _loadingItems.add(productId);
    state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));

    final tempState = await ref.watch(cartRepositoryProvider).addToCart(productId, quantity: quantity);

    _loadingItems.remove(productId);
    state = AsyncValue.data(tempState.copyWith(loadingItems: _loadingItems.toList()));

    // TODO : uncomment if you need to hit the build meathod again Not needed now
    // ref.invalidateSelf();
  }


  getQuantity(int id) {
    return state.value?.items?.firstWhere((element) => element.id == id).quantity;
  }

  Future<void> updateItem({required String itemKey, required int quantity}) async {
    if (quantity == 0) {
      final tempState = await ref.watch(cartRepositoryProvider).removeItem(itemKey);

      state = AsyncValue.data(tempState);
    } else {
      final item = state.value!.items!.firstWhere((element) => element.key == itemKey);
      _loadingItems.add(item.id!);
      state = AsyncValue.data(state.value!.copyWith(loadingItems: _loadingItems.toList()));

      final tempState = await ref.watch(cartRepositoryProvider).updateItem(itemKey, quantity: quantity);

      _loadingItems.remove(item.id);
      state = AsyncValue.data(tempState.copyWith(loadingItems: _loadingItems.toList()));
    }
  }


  removeItem({required String itemKey, int quantity = 1}) async {
    final tempState = await ref.watch(cartRepositoryProvider).removeItem(itemKey);

    state = AsyncValue.data(tempState);
  }

  bool isItemLoading(int id) {
    return _loadingItems.contains(id);
  }
}

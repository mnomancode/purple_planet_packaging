import 'package:purple_planet_packaging/app/extensions/double_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/model/cart_model.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/cart_state.dart';
import '../repository/cart_repository_impl.dart';

part 'cart_providers.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  CartState build() {
    return const CartState();
  }

// add to cart
  void addToCart(ProductsModel product) async {
    await ref.read(cartRepositoryProvider).getCart('');
    ref.read(cartRepositoryProvider).addToCart(product.id);
    // if (state.items.any((element) => element.product.id == product.id)) {
    //   state = state.copyWith(
    //     items: [
    //       ...state.items.where((element) => element.product.id != product.id),
    //       CartModel(
    //           product: product,
    //           quantity: state.items.firstWhere((element) => element.product.id == product.id).quantity + 1),
    //     ].toList()
    //       ..sort((a, b) => a.product.id.compareTo(b.product.id)),
    //   );
    //   setSubTotal();
    //   return;
    // }
    //
    // state = state.copyWith(
    //   items: [...state.items, CartModel(product: product)].toList()
    //     ..sort((a, b) => a.product.id.compareTo(b.product.id)),
    // );
    // setSubTotal();
  }

  void removeFromCart(int productId) {
    if (state.items.firstWhere((element) => element.product.id == productId).quantity == 1) {
      state = state.copyWith(
        items: [...state.items.where((element) => element.product.id != productId)].toList()
          ..sort((a, b) => a.product.id.compareTo(b.product.id)),
      );
      setSubTotal();

      return;
    }
    state = state.copyWith(
      items: [
        ...state.items.where((element) => element.product.id != productId),
        CartModel(
            product: state.items.firstWhere((element) => element.product.id == productId).product,
            quantity: state.items.firstWhere((element) => element.product.id == productId).quantity - 1),
      ].toList()
        ..sort((a, b) => a.product.id.compareTo(b.product.id)),
    );
    setSubTotal();
  }

  getQuantity(int id) {
    return state.items.firstWhere((element) => element.product.id == id).quantity;
  }

  getTotalPrice(int id) {
    return state.items.firstWhere((element) => element.product.id == id).getPrice ??
        1 * state.items.firstWhere((element) => element.product.id == id).quantity;
  }

  setSubTotal() {
    state = state.copyWith(subTotal: subTotal().roundToPlaces(2));
  }

  double subTotal() {
    return state.items.fold(0.0, (previousValue, element) {
      return previousValue + element.getPrice! * (double.tryParse(element.quantity.toString()) ?? 1);
    });
  }
}

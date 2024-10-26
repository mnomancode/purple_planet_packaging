import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purple_planet_packaging/app/models/products/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/shop_repository_impl.dart';

part 'product_state.g.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    required Product product,
    String? selectedAttributeOption,
    @Default(false) bool isLoading,
    @Default(null) String? error,
  }) = _ProductState;
}

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  ProductState build(Product product) {
    return ProductState(product: product, selectedAttributeOption: product.attributes.first.options.first);
  }

  Future<void> loadProduct(int productId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final product = await ref.read(shopRepositoryProvider).getProduct(productId);
      state = state.copyWith(product: product, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void updateSelectedOption({required String option}) async {
    state = state.copyWith(selectedAttributeOption: option, isLoading: true);
    Product product = await ref.read(shopRepositoryProvider).getProduct(_findMatchingVariation(option));

    state = state.copyWith(product: product, isLoading: false);
  }

  int _findMatchingVariation(String option) {
    int index = state.product.attributes.first.options.indexWhere((element) => element == option);

    return state.product.variations[index];
  }

  // Future<void> loadProduct(int productId) async {
  //   state = state.copyWith(isLoading: true, error: null);
  //   try {
  //     // Simulate API call - replace with actual API call
  //     final json = // Your JSON data here
  //     final product = ProductModel.fromJson(json);

  //     // Initialize selected attributes with first option of each attribute
  //     final initialAttributes = Map.fromEntries(
  //       product.attributes
  //           .where((attr) => attr.options.isNotEmpty)
  //           .map((attr) => MapEntry(attr.name, attr.options.first))
  //     );

  //     state = state.copyWith(
  //       product: product,
  //       selectedAttributes: initialAttributes,
  //       isLoading: false,
  //     );
  //   } catch (e) {
  //     state = state.copyWith(
  //       error: e.toString(),
  //       isLoading: false,
  //     );
  //   }
  // }

  // void updateAttribute(String attributeName, String value) {
  //   state = state.copyWith(
  //     selectedAttributes: {...state.selectedAttributes, attributeName: value}
  //   );
  //   _onAttributeChanged(attributeName, value);
  // }

  // void _onAttributeChanged(String attributeName, String value) {
  //   // Implement your attribute change logic here
  //   print('Attribute: $attributeName changed to: $value');
  // }
}

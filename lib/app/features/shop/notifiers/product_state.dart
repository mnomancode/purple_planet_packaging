import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purple_planet_packaging/app/models/products/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_state.g.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    required Product product,
    String? selectedAttributeOption,
    @Default('') String selectedPrice,
    int? defaultVariation,
    @Default(false) bool isLoading,
    @Default(null) String? error,
  }) = _ProductState;
}

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  ProductState build(Product product) {
    String? defaultAttributeOption;

    if (product.defaultAttributes == null || product.defaultAttributes!.isEmpty) {
      defaultAttributeOption = null;
    } else {
      defaultAttributeOption = product.defaultAttributes?.first.option;
    }
    if (defaultAttributeOption == null) {
      return ProductState(product: product, defaultVariation: product.id, selectedPrice: product.price);
    }

    return ProductState(
        product: product,
        selectedAttributeOption: defaultAttributeOption,
        selectedPrice: product.pricesList[findIndex(defaultAttributeOption)],
        defaultVariation: _findMatchingVariation(defaultAttributeOption));
  }

  // Future<void> loadProduct(int productId) async {
  //   state = state.copyWith(isLoading: true, error: null);
  //   try {
  //     final product = await ref.read(shopRepositoryProvider).getProduct(productId);
  //     state = state.copyWith(product: product, isLoading: false);
  //   } catch (e) {
  //     state = state.copyWith(
  //       error: e.toString(),
  //       isLoading: false,
  //     );
  //   }
  // }

  void updateSelectedOption({required String option}) async {
    String price = state.product.pricesList[findIndex(option)];
    state = state.copyWith(
        selectedAttributeOption: option, selectedPrice: price, defaultVariation: _findMatchingVariation(option));
  }

  int findIndex(String option) {
    List<String> options = product.attributes.first.options!;

    return options.indexOf(option);
  }

  int _findMatchingVariation(String? option) {
    if (option == null) {
      return product.id;
    }

    return product.variations[findIndex(option)];
  }
}

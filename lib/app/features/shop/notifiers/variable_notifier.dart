import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class VariableProduct {
  final int productId;
  final int selectedVariationId;

  VariableProduct({required this.productId, required this.selectedVariationId});
}

final variableNotifierProvider = Provider.family<VariableProduct, int>((ref, productId, {int selectedVariationId = 0}) {
  return VariableProduct(productId: productId, selectedVariationId: selectedVariationId);
});

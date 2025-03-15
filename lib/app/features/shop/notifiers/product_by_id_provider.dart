// Future provider using Riverpod Generator
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/products/product.dart';
import '../repository/shop_repository_impl.dart';

part 'product_by_id_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Product> productByVariant(ProductByVariantRef ref, int variantId) async {
  final repository = ref.read(shopRepositoryProvider);
  return repository.getProduct(variantId);
}

// StateNotifier to keep track of selected variant
@riverpod
class SelectedProductVariantNotifier extends _$SelectedProductVariantNotifier {
  @override
  Product? build({Product? defaultProduct}) => defaultProduct;

  void selectVariant(Product product) {
    state = product;
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/products/products.dart';
import '../../shop/repository/shop_repository_impl.dart';

part 'product_featured_notifier.freezed.dart';
part 'product_featured_notifier.g.dart';

@freezed
class ProductFeaturedSate with _$ProductFeaturedSate {
  const factory ProductFeaturedSate({
    @Default(0) int offset,
    @Default(false) bool isLoading,
    @Default([]) List<ProductsModel> products,
  }) = _ProductFeaturedSate;
}

@riverpod
class FeaturedProductsNotifier extends _$FeaturedProductsNotifier {
  @override
  Future<ProductFeaturedSate> build() {
    return _loadProducts();
  }

  loadMore({String? query}) {
    update((p) async {
      final newState = p.copyWith(isLoading: true);

      return newState;
    });

    update((p) async {
      final products = await ref.watch(shopRepositoryProvider).getFeatureProducts(offset: p.offset + 10);
      final newState = p.copyWith(isLoading: false, products: [...p.products, ...products], offset: p.offset + 10);
      ref.keepAlive();

      return newState;
    });
  }

  Future<ProductFeaturedSate> _loadProducts({int offset = 0}) async {
    final products = await ref.watch(shopRepositoryProvider).getFeatureProducts();

    return ProductFeaturedSate(products: products, offset: offset);
  }
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'featured_products_repository.dart';

class FeaturedProductsRepositoryImpl extends FeaturedProductsRepository {
  // TODO add your methods here
}

final featuredProductsRepositoryProvider = Provider<FeaturedProductsRepository>((ref) {
  return FeaturedProductsRepositoryImpl();
});

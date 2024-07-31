import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository {
  // TODO add your methods here
}

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepositoryImpl();
});

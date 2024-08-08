import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'order_samples_repository.dart';

class OrderSamplesRepositoryImpl extends OrderSamplesRepository {
  // TODO add your methods here
}

final orderSamplesRepositoryProvider = Provider<OrderSamplesRepository>((ref) {
  return OrderSamplesRepositoryImpl();
});

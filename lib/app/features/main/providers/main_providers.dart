import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';

import '../../../provider/shared_preferences_storage_service_provider.dart';

final cartFutureProvider = FutureProvider<void>((ref) async {
  final cart = await ref.read(newCartNotifierProvider.notifier).getCart();

  String? cartToken = cart.cartKey;
  await ref.read(storageServiceProvider).set('cart_key', cartToken);

  return;
});

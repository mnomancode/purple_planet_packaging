import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';

final cartFutureProvider = FutureProvider<void>((ref) async {
  await ref.read(newCartNotifierProvider.notifier).getCart();
});

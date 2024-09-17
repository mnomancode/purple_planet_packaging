import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/repository/cart_repository_impl.dart';

final cartFutureProvider = FutureProvider<void>((ref) async {
  await ref.read(cartRepositoryProvider).getCart('');
});

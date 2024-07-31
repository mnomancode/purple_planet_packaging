import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartView extends ConsumerWidget {
  /// TODO add your comment here
  const CartView({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox(child: Text(routeName));
  }
}

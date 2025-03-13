import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_styles.dart';
import '../notifiers/cart_notifier.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key, this.height = 50});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AppBar(
      title: const Text('My Cart'),
      centerTitle: true,
      actions: [
        Consumer(builder: (context, ref, child) {
          return ref.watch(newCartNotifierProvider).when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.itemCount < 10 ? '0${data.itemCount} Items' : '${data.itemCount} Items',
                      style: AppStyles.mediumBoldStyle(),
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              );
        })
      ],
    ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

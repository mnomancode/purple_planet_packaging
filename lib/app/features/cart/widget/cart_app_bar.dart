import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/commons/search_text_field.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';

import '../../../core/utils/app_styles.dart';
import '../notifiers/cart_notifier.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key, this.height = 50});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AppBar(
      title: const Text('Cart'),
      centerTitle: true,
      actions: [
        Consumer(builder: (context, ref, child) {
          return ref.watch(newCartNotifierProvider).when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.cartTotals!.totalItems?.addDecimalFromEnd(data.cartTotals?.currencyMinorUnit ?? 0) ?? '0.00',
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

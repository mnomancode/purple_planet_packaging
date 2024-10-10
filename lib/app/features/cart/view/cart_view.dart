import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';

import 'package:purple_planet_packaging/app/features/cart/widget/cart_app_bar.dart';
import 'package:purple_planet_packaging/app/features/cart/widget/cart_bottom_sheet.dart';
import 'package:purple_planet_packaging/app/features/cart/widget/cart_item.dart';

import '../../../core/utils/app_styles.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CartAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: SvgPicture.asset(AppImages.svgCart, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        label: Text('Check-out', style: AppStyles.mediumBoldStyle()),
        onPressed: () async {
          showModalBottomSheet(
              context: context,
              isDismissible: true,
              showDragHandle: true,
              enableDrag: true,
              scrollControlDisabledMaxHeightRatio: 0.7,
              builder: (context) {
                return const CartBottomSheet();
              });
        },
      ),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ref.watch(newCartNotifierProvider).when(
                  data: (data) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final cartItem = data.items![index];

                          return CartItem(item: cartItem);
                        },
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Text('$error'),
                )
          ],
        ),
      ),
    );
  }
}

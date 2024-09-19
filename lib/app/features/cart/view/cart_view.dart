import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/model/cart_model.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/cart/providers/cart_providers.dart';
import 'package:purple_planet_packaging/app/features/cart/repository/cart_repository_impl.dart';
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
      // resizeToAvoidBottomInset: false,
      // bottomSheet: const CartBottomSheet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: SvgPicture.asset(AppImages.svgCart, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        label: Text('Check-out', style: AppStyles.mediumBoldStyle()),
        onPressed: () async {
          // await ref.read(cartRepositoryProvider).getCart('');
          // ref.read(cartRepositoryProvider).addToCart(6590);

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
          children: [
            // ...ref.watch(cartNotifierProvider).items.map((e) => CartItem(cartModel: e)),
            ref.watch(newCartNotifierProvider).when(
                  data: (data) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final cartItem = data.items![index];

                          // TODO: widget already exists update it according to new cart model
                          // CartItem(cartModel: cartItem);

                          return ListTile(
                            title: Text(cartItem.name ?? ''),
                            subtitle: Text('${cartItem.quantity}'),
                            // trailing: Text('${cartItem.prices?.price?.addDecimalFromEnd(2) ?? 0}'),

                            // only a dummy decimal point
                            trailing: Text('${cartItem.prices?.price?.addDecimalFromEnd(2) ?? 0}'),
                            onTap: () {
                              // ref.read(cartNotifierProvider.notifier).addToCart(cartItem);
                            },
                          );
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

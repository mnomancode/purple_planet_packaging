import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/price_widget.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/cart/model/cart_model.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/cart/providers/cart_providers.dart';
import 'package:purple_planet_packaging/app/models/cart/new_cart_model.dart';

class CartItem extends ConsumerWidget {
  const CartItem({Key? key, required this.item}) : super(key: key);

  //final CartModel cartModel;
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 130.h,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: AppStyles.roundBorder,
            width: 110.h,
            padding: EdgeInsets.all(10.h),
            child: CachedNetworkImage(imageUrl: item.images!.first.src!),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${item.name}',
                  style: AppStyles.mediumBoldStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
              8.verticalSpace,
              Row(
                children: [
                  PriceWidget(item.prices!, onlyPrice: true),
                  8.horizontalSpace,
                ],
              ),
              Row(
                children: [
                  //TODO: Add functionality
                  IconButton(
                    // onPressed: () => ref.read(cartNotifierProvider.notifier).removeFromCart(cartModel.product.id),
                    onPressed: () {},
                    icon: const Icon(Icons.remove),
                    style: IconButton.styleFrom(backgroundColor: AppColors.lightPrimaryColor),
                  ),
                  SizedBox(
                    width: 25.w,
                    child: Text(ref.watch(newCartNotifierProvider.notifier).getQuantity(item.id!).toString(),
                        style: AppStyles.boldStyle(), textAlign: TextAlign.center),
                  ),
                  //TODO: Add functionality
                  IconButton(
                    // onPressed: () => ref.read(cartNotifierProvider.notifier).addToCart(cartModel.product),
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(backgroundColor: AppColors.lightPrimaryColor),
                  ),
                  // Text(
                  //     // ignore: prefer_interpolation_to_compose_strings
                  //     '=' +
                  //         (ref.watch(cartNotifierProvider.notifier).getQuantity(cartModel.product.id) *
                  //                 cartModel.getPrice)
                  //             .toStringAsFixed(2),
                  //     style: AppStyles.boldStyle()),
                  Transform.translate(
                    offset: const Offset(0, 3),
                    child: Text(
                      ' exc. VAT',
                      textScaler: const TextScaler.linear(0.6),
                      textAlign: TextAlign.left,
                      style: AppStyles.lightStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
          4.horizontalSpace,
          const Icon(Icons.close, color: Colors.red),
        ],
      ),
    );
  }
}

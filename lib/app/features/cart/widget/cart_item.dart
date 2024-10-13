import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/models/cart/cart_model.dart';

class CartItemWidget extends ConsumerWidget {
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  //final CartModel cartModel;
  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.watch(newCartNotifierProvider.notifier);
    final isLoading = cartNotifier.isItemLoading(item.id);
    return SizedBox(
      height: 130.h,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: AppStyles.roundBorder,
            width: 100.h,
            height: 100.h,
            padding: EdgeInsets.all(10.h),
            child: CachedNetworkImage(imageUrl: item.images.first.src, width: 100.h, height: 100.h),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: AppStyles.mediumBoldStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
              8.verticalSpace,
              Row(
                children: [
                  // PriceWidget(item.prices!, onlyPrice: true),
                  8.horizontalSpace,
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => ref
                        .read(newCartNotifierProvider.notifier)
                        .updateItem(itemKey: item.key, quantity: item.quantity - 1),
                    icon: const Icon(Icons.remove),
                    style: IconButton.styleFrom(backgroundColor: AppColors.lightPrimaryColor),
                  ),
                  isLoading
                      ? SizedBox(
                          width: 25.w,
                          height: 25.w,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : SizedBox(
                          width: 25.w,
                          child: Text(cartNotifier.getQuantity(item.id).toString(),
                              style: AppStyles.boldStyle(), textAlign: TextAlign.center),
                        ),
                  IconButton(
                    onPressed: () => ref.read(newCartNotifierProvider.notifier).addToCart(productId: item.id),
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(backgroundColor: AppColors.lightPrimaryColor),
                  ),
                  Text('=${item.totals.formattedLineTotal}', style: AppStyles.boldStyle()),
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
          IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.topRight,
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => ref.read(newCartNotifierProvider.notifier).removeItem(itemKey: item.key),
          )
        ],
      ),
    );
  }
}

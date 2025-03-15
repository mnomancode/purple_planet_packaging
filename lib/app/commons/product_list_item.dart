import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_price_widget.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../features/shop/view/product_details/product_details_view.dart';
import '../models/products/product.dart';

class ProductListItem extends ConsumerWidget {
  const ProductListItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 210.w,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: GestureDetector(
        onTap: () => context.pushNamed(
          ProductDetailsView.routeName,
          pathParameters: {'title': product.name},
          extra: product,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130.h,
              width: 200.w,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: CachedNetworkImageProvider(product.images.first.src), fit: BoxFit.contain),
              ),
              child: product.stockStatus == StockStatus.instock
                  ? GestureDetector(
                      onTap: () {
                        // if has variations add to cart
                        if (product.variations.isNotEmpty) {
                          context.pushNamed(ProductDetailsView.routeName,
                              pathParameters: {'title': product.name}, extra: product);
                          return;
                        }

                        ref.read(newCartNotifierProvider.notifier).addToCart(productId: product.id, context: context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.lightPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(AppImages.svgAddCard, width: 20),
                      ),
                    )
                  : Container(
                      foregroundDecoration: const RotatedCornerDecoration.withColor(
                        color: Colors.red,
                        spanBaselineShift: 4,
                        badgeSize: Size(64, 64),
                        badgeCornerRadius: Radius.circular(8),
                        badgePosition: BadgePosition.topEnd,
                        textSpan: TextSpan(
                          text: 'Out of stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
            5.verticalSpace,
            Text(product.name,
                style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor, fontSize: 13.sp),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
            const Spacer(),
            const Divider(color: AppColors.lightGreyColor),
            ProductPriceWidget(product.price, columnView: true),
          ],
        ),
      ),
    );
  }
}

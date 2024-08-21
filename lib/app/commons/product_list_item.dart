import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, this.onTap, required this.product});
  final void Function()? onTap;
  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130.h,
              width: 200.w,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: CachedNetworkImageProvider(product.images!.first.src), fit: BoxFit.contain),
              ),
              child: GestureDetector(
                onTap: () {
                  //TODO: Add to cart
                  log('Add to cart');
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(AppImages.svgAddCard, width: 20),
                ),
              ),
            ),
            10.verticalSpace,
            Text(product.name,
                style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
            const Divider(color: AppColors.lightGreyColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price', style: AppStyles.boldStyle(color: AppColors.primaryColor)),
                Text('£ 10.00', style: AppStyles.boldStyle(color: AppColors.primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

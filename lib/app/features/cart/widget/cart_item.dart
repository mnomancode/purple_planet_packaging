import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: AppStyles.roundBorder,
            width: 110.h,
            padding: EdgeInsets.all(10.h),
            child: Image.asset(AppImages.cup),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Planetware™ 8oz Double Wall Takeaway  Cup',
                  style: AppStyles.mediumBoldStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
              8.verticalSpace,
              Text('₹ 100', style: AppStyles.largeStyle()),
              8.verticalSpace,
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(Icons.remove, size: 20, color: AppColors.primaryColor),
                  ),
                  8.horizontalSpace,
                  Text('1', style: AppStyles.boldStyle()),
                  8.horizontalSpace,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(Icons.add, size: 20, color: AppColors.primaryColor),
                  ),
                ],
              ),
            ],
          )),
          8.horizontalSpace,
          const Icon(Icons.close, color: Colors.red),
        ],
      ),
    );
  }
}

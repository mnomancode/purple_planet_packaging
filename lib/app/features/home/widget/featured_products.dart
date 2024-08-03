import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../commons/product_list_item.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 30.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Products',
                  style: AppStyles.mediumBoldStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text('View All', style: TextStyle(fontSize: 14.sp)),
              ],
            ),
          ),
        ),
        6.verticalSpace,
        Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 16.w),
          height: 250.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => 14.horizontalSpace,
            itemCount: 7,
            itemBuilder: (context, index) {
              return const ProductListItem();
            },
          ),
        ),
      ],
    );
  }
}

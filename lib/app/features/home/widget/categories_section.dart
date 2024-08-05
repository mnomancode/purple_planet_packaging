import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

import '../../../commons/category_list_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

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
                Text('Categories', style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor, fontSize: 16.sp)),
                Text('View All', style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey)),
              ],
            ),
          ),
        ),
        6.verticalSpace,
        Container(
          margin: EdgeInsets.only(left: 16.w),
          alignment: Alignment.topCenter,
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => 14.horizontalSpace,
            itemCount: 7,
            itemBuilder: (context, index) {
              return const CategoryListItem();
            },
          ),
        ),
      ],
    );
  }
}

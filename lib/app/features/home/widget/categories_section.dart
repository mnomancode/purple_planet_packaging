import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/context_extensions.dart';
import 'package:purple_planet_packaging/app/features/shop/notifiers/shop_notifier.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../commons/category_list_item.dart';
import '../../shop/repository/shop_repository_impl.dart';
import '../../shop/view/shop_view.dart';

class CategoriesSection extends ConsumerWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(shopNotifierProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 33.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories', style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor, fontSize: 16.sp)),
                GestureDetector(
                    onTap: () {
                      context.goNamed(ShopView.routeName);
                    },
                    child: Text('View All', style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey))),
              ],
            ),
          ),
        ),
        6.verticalSpace,
        Container(
          margin: EdgeInsets.only(left: 16.w),
          alignment: Alignment.topCenter,
          height: 116.h,
          child: categories.when(
            data: (data) => ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => 14.horizontalSpace,
              itemCount: (context.isTablet) ? 10 : 7,
              itemBuilder: (context, index) {
                return CategoryListItem(categoryModel: data[index]);
              },
            ),
            error: (Object error, StackTrace stackTrace) => Text(error.toString()),
            loading: () => Container(
              margin: EdgeInsets.only(left: 16.w),
              alignment: Alignment.topCenter,
              height: 110.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => 14.horizontalSpace,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Skeletonizer.zone(child: Bone.circle(size: 70.h)),
                      10.verticalSpace,
                      Skeletonizer.zone(child: Bone.text(width: 70.w)),
                    ],
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

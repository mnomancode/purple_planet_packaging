import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/featured_products/notifiers/product_featured_notifier.dart';
import 'package:purple_planet_packaging/app/features/featured_products/view/featured_products_view.dart';

import '../../../commons/product_list_item.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';

class FeaturedProductsSection extends ConsumerWidget {
  const FeaturedProductsSection({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.leftMargin = 16,
    required this.title,
  });
  final EdgeInsets padding;
  final double leftMargin;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = ref.watch(featuredProductsNotifierProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: SizedBox(
            height: 30.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.mediumBoldStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                  ),
                ),
                GestureDetector(
                    onTap: () => context.pushNamed(FeaturedProductsView.routeName),
                    child: Text('View All', style: TextStyle(fontSize: 14.sp))),
              ],
            ),
          ),
        ),
        6.verticalSpace,
        Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: leftMargin.w),
            height: 280.h,
            child: featured.when(
              data: (data) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => 14.horizontalSpace,
                  itemCount: data.products.length,
                  itemBuilder: (context, index) {
                    return ProductListItem(product: data.products[index]);
                  },
                );
              },
              error: (error, stackTrace) {
                return const Text('Error');
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
      ],
    );
  }
}

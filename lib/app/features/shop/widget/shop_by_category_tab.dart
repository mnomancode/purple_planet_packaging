import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/shop/view/products_view.dart';

import '../../../commons/category_grid_item.dart';
import '../../../core/utils/app_colors.dart';

class ShopByCategory extends StatelessWidget {
  const ShopByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Text('Choose category',
            style: AppStyles.mediumStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16.sp)),
        8.verticalSpace,
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: 100,
              cacheExtent: 1000,
              itemBuilder: (context, index) {
                return CategoryGridItem(
                  title: 'Bagasse Gourmet Range',
                  url: 'https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/Bagasse-Gourmet.svg',
                  onTap: () {
                    context.goNamed(
                      ProductsView.routeName,
                      queryParameters: {'title': 'Bagasse Gourmet Range', 'categoryId': '1'},
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}

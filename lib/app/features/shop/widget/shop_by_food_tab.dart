import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../commons/category_grid_item.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../view/products_view.dart';

class ShopByFood extends StatelessWidget {
  const ShopByFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Text('Choose Food Type',
            style: AppStyles.mediumStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16.sp)),
        8.verticalSpace,
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
              ),
              itemCount: 100,
              cacheExtent: 1000,
              itemBuilder: (context, index) {
                return CategoryGridItem(
                  title: 'Burger',
                  url: 'https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/Burger.svg',
                  onTap: () => context.goNamed(
                    ProductsView.routeName,
                    queryParameters: {'title': 'Burger', 'categoryId': '1'},
                  ),
                );
              }),
        ),
      ],
    );
  }
}

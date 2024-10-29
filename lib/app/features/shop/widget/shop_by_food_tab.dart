import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/shop/notifiers/food_type_notifier.dart';

import '../../../commons/category_grid_item.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../view/products_view.dart';

class ShopByFood extends ConsumerWidget {
  const ShopByFood({super.key});
  // https://staging.purpleplanetpackaging.co.uk/wp-json/wc/v3/products?attribute=2&attribute_term=40
  // https://staging.purpleplanetpackaging.co.uk/wp-json/wc/v3/products/attribute/2/terms

// /products?attribute=2&attribute_term=244
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Text('Choose Food Type',
            style: AppStyles.mediumStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16.sp)),
        8.verticalSpace,
        ref.watch(foodTypeNotifierProvider).when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            data: (data) {
              return Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: data.length,
                    cacheExtent: 1000,
                    itemBuilder: (context, index) {
                      return CategoryGridItem(
                        title: data[index].name,
                        url: 'https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/Burger.svg',
                        onTap: () => context.goNamed(
                          ProductsView.routeName,
                          queryParameters: {
                            'title': data[index].name,
                            'categoryId': '1',
                            'term': data[index].id.toString()
                          },
                        ),
                      );
                    }),
              );
            }),
      ],
    );
  }
}

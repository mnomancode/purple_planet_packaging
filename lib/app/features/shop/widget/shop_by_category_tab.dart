import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/shop/notifiers/shop_notifier.dart';
import 'package:purple_planet_packaging/app/features/shop/repository/shop_repository_impl.dart';
import 'package:purple_planet_packaging/app/features/shop/view/products_view.dart';

import '../../../commons/category_grid_item.dart';
import '../../../core/utils/app_colors.dart';

class ShopByCategory extends ConsumerWidget {
  const ShopByCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shop = ref.watch(shopNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpace,
        Text('Choose category',
            style: AppStyles.mediumStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600, fontSize: 16.sp)),
        8.verticalSpace,
        shop.when(
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
                    childAspectRatio: 1,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CategoryGridItem(
                      title: data[index].name,
                      url: data[index].image!.src!,
                      onTap: () {
                        context.goNamed(
                          ProductsView.routeName,
                          queryParameters: {'title': data[index].name, 'categoryId': '${data[index].id}'},
                        );
                      },
                    );
                    //// CategoryGridItem(
                    //   title: 'Bagasse Gourmet Range',
                    //   url: 'https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/Bagasse-Gourmet.svg',
                    //   onTap: () {
                    //     context.goNamed(
                    //       ProductsView.routeName,
                    //       queryParameters: {'title': 'Bagasse Gourmet Range', 'categoryId': '1'},
                    //     );
                    //   },
                    // );
                  }),
            );
          },
        )
      ],
    );
  }
}

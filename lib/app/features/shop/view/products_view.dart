import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/shop/notifiers/food_type_notifier.dart';

import '../../../commons/ppp_app_bar.dart';
import '../../../commons/product_list_item.dart';
import '../notifiers/shop_notifier.dart';
import 'widgets/products_loading_gridview.dart';

class ProductsView extends ConsumerWidget {
  ProductsView({super.key, required this.pageTitle, required this.categoryId, this.term});

  static const routeName = 'products';
  static const titleParm = 'title';
  static const categoryIdParm = 'categoryId';

  final String pageTitle;
  final String categoryId;
  String? term;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = term == null
        ? ref.watch(productsNotifierProvider(categoryId: int.tryParse(categoryId)))
        : ref.watch(foodTypeProductsNotifierProvider(term!));

    return Scaffold(
      appBar: PPPAppBar(
        title: pageTitle.replaceAll('&amp;', '&'),
        // action: CircleAvatar(backgroundColor: Colors.white, child: SvgPicture.asset(AppImages.svgFilter)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor, fontSize: 16.sp),
            ),
            8.verticalSpace,
            Expanded(
              child: products.when(
                data: (data) => GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ProductListItem(
                        product: data[index],
                        // onTap: () {
                        //   context.pushNamed(
                        //     ProductDetailsView.routeName,
                        //     pathParameters: {'title': pageTitle},
                        //     // queryParameters: {'productId': 'product_$index'},
                        //     extra: data[index],
                        //   );
                        // },
                      );
                    }),
                error: (Object error, StackTrace stackTrace) => Text(error.toString()),
                loading: () => const ProductsLoadingGridView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

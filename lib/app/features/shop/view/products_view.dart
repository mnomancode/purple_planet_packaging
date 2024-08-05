import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

import '../../../commons/ppp_app_bar.dart';
import '../../../commons/product_list_item.dart';
import 'product_details/product_details_view.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key, required this.title, required this.categoryId});

  static const routeName = 'products';
  static const titleParm = 'title';
  static const categoryIdParm = 'categoryId';

  final String title;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PPPAppBar(
        title: title,
        action: CircleAvatar(backgroundColor: Colors.white, child: SvgPicture.asset(AppImages.svgFilter)),
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 100,
                itemBuilder: (context, index) => ProductListItem(
                  onTap: () {
                    context.pushNamed(
                      ProductDetailsView.routeName,
                      pathParameters: {'title': title},
                      queryParameters: {'productId': 'product_$index'},
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/app_colors.dart';
import '../features/shop/view/products_view.dart';
import '../models/categories/category.dart';
import 'svg_network.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        ProductsView.routeName,
        queryParameters: {'title': categoryModel.name, 'categoryId': '${categoryModel.id}'},
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 35.r,
              backgroundColor: AppColors.primaryColor,
              child: SvgNetwork(url: categoryModel.image?.src ?? '')),
          4.verticalSpace,
          SizedBox(
              width: 70.w,
              child:
                  Text(categoryModel.name, style: TextStyle(fontSize: 12.sp, color: AppColors.darkGrey), maxLines: 2)),
        ],
      ),
    );
  }
}

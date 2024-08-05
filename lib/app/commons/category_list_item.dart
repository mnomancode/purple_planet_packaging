import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';
import 'svg_network.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 35.r,
            backgroundColor: AppColors.primaryColor,
            child: const SvgNetwork(
              url: 'https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/Bagasse-Gourmet.svg',
            )),
        4.verticalSpace,
        Text('Category', style: TextStyle(fontSize: 12.sp, color: AppColors.darkGrey)),
      ],
    );
  }
}

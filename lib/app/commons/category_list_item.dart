import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/app_colors.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35.r,
          backgroundColor: AppColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.network(
              'https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/Bagasse-Gourmet.svg',
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
        4.verticalSpace,
        Text('Category', style: TextStyle(fontSize: 12.sp, color: AppColors.darkGrey)),
      ],
    );
  }
}

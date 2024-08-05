import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_styles.dart';
import 'svg_network.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.url, required this.title, this.onTap});
  final String url;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0.r),
        boxShadow: [
          BoxShadow(
              color: AppColors.lightPrimaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(1, 3)),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: SvgNetwork(url: url, padding: const EdgeInsets.all(20))),
            8.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(title, style: AppStyles.mediumStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

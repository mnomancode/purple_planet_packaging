// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

import '../../../core/utils/app_colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.height = 180});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        height: height,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        child: Column(
          children: [
            20.verticalSpace,
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello,', style: AppStyles().largeStyle(color: AppColors.white)),
                    Text('John Doe', style: AppStyles().largeStyle(color: AppColors.white)),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.svgSampleCart),
                    3.verticalSpace,
                    Text('Order\nSample',
                        style: AppStyles().lightStyle(color: AppColors.white), textAlign: TextAlign.center)
                  ],
                ),
                5.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.svgPrinter),
                    3.verticalSpace,
                    Text('Custom\nPrint',
                        style: AppStyles().lightStyle(color: AppColors.white), textAlign: TextAlign.center)
                  ],
                ),
              ],
            ),
            16.verticalSpace,
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Products',
                fillColor: AppColors.white,
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 5),
                  child: SvgPicture.asset(AppImages.svgSearch),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

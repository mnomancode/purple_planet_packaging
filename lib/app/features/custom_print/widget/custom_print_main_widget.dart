import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/context_extensions.dart';
import 'package:purple_planet_packaging/app/features/custom_print/view/get_started_view.dart';

import '../../../core/utils/app_colors.dart';

class CustomPrintMainWidget extends StatelessWidget {
  const CustomPrintMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.h),
        height: 185.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0,
              top: -18.h,
              child: Image.asset(AppImages.cup, width: context.isTablet ? 140.w : 0.28.sw),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 0.50.sw, child: Text('Custom Print', style: AppStyles.boldStyle(fontSize: 18.sp))),
                  8.verticalSpace,
                  SizedBox(
                    width: 0.60.sw,
                    child: Text(
                      'Elevate your brand’s visibility and leave a lasting impression on your customers.',
                      style: AppStyles.mediumStyle(fontSize: 13.sp),
                    ),
                  ),
                  10.verticalSpace,
                  GestureDetector(
                    onTap: () => context.pushNamed(GetStarted.routeName),
                    child: Container(
                      width: 0.3.sw,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [AppColors.lightGreen, AppColors.secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.1, 0.9],
                        ),
                      ),
                      child: Text('Get Started',
                          style: AppStyles.mediumBoldStyle(color: AppColors.white, fontSize: 14.sp)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/context_extensions.dart';

import '../../../core/utils/app_colors.dart';

class ResponsiblePackaging extends StatelessWidget {
  const ResponsiblePackaging({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
          margin: EdgeInsets.only(top: 20.h),
          height: 190.h,
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
                    SizedBox(
                        width: 0.50.sw,
                        child: Text('RESPONSIBLE PACKAGING', style: AppStyles.boldStyle(fontSize: 18.sp))),
                    6.verticalSpace,
                    Text(
                      'Eco-friendly packaging made from\nrecycled or renewable materials.',
                      style: AppStyles.mediumStyle(fontSize: 13.sp),
                    ),
                    8.verticalSpace,
                    Container(
                      width: 0.3.sw,
                      height: 35.h,
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
                      child:
                          Text('Shop Now', style: AppStyles.mediumBoldStyle(color: AppColors.white, fontSize: 14.sp)),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

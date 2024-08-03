import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';

import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_styles.dart';

class OrderByWidgetHome extends StatelessWidget {
  const OrderByWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 0.75.sw,
            child: Text('Order by 2pm to get free UK mainland next day delivery',
                style: AppStyles.mediumStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          const Spacer(),
          SvgPicture.asset(AppImages.svgTruck, height: 28, width: 28),
        ],
      ),
    );
  }
}

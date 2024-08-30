import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/extensions/elevated_button_extensions.dart';

import '../../../core/utils/app_images.dart';
import '../../custom_print/view/custom_print_view.dart';
import '../../order_samples/view/order_samples_view.dart';

class CustomPrintSampleButtons extends StatelessWidget {
  const CustomPrintSampleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () => context.pushNamed(OrderSamplesView.routeName),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.svgSampleCart,
                        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                      ),
                      5.horizontalSpace,
                      const Text('Order Sample'),
                    ],
                  )).alterP(isTransparent: true)),
          16.horizontalSpace,
          Expanded(
              child: ElevatedButton(
                  onPressed: () => context.pushNamed(CustomPrintView.routeName),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppImages.svgPrinter),
                      4.horizontalSpace,
                      const Text('Custom Print'),
                    ],
                  ))),
        ],
      ),
    );
  }
}

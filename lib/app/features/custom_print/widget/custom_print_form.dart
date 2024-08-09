import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';

class CustomPrintForm extends StatelessWidget {
  const CustomPrintForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
        ).withLabel('Name'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your Email',
            border: OutlineInputBorder(),
          ),
        ).withLabel('Email'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your Phone',
            border: OutlineInputBorder(),
          ),
        ).withLabel('Phone'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Enter your Message',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ).withLabel('Message'),
        8.verticalSpace,
        DottedBorder(
          color: AppColors.darkGrey,
          strokeWidth: 1,
          radius: const Radius.circular(10),
          borderType: BorderType.RRect,
          dashPattern: const [5, 5],
          child: SizedBox(
            width: 1.sw,
            height: 120.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.svgUpload),
                AppStyles.heading('Artwork Upload'),
                const Text('Upload your design', style: TextStyle(color: AppColors.greyColor)),
              ],
            ),
          ),
        ),
        16.verticalSpace,
        ElevatedButton(onPressed: () {}, child: const Text('Send')),
        16.verticalSpace,
      ],
    );
  }
}

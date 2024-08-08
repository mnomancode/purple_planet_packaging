// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

import '../widget/custom_print_form.dart';
import '../widget/custom_print_main_widget.dart';

class GetStarted extends ConsumerWidget {
  const GetStarted({Key? key}) : super(key: key);

  static const routeName = 'getStarted';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PPPAppBar(title: 'Custom Print'),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.heading('Get Started'),
              8.verticalSpace,
              AppStyles.normalText(
                  'Ready to bring your ideas to life? Use the form below to get started on your custom print project. Don’t forget to upload your designs, and we’ll reach out to you soon!'),
              16.verticalSpace,
              IconTextWidget(icon: SvgPicture.asset(AppImages.svgEmail), text: 'sales@purpleplanetpackaging.co.uk'),
              8.verticalSpace,
              IconTextWidget(icon: SvgPicture.asset(AppImages.svgPhone), text: 'sales@purpleplanetpackaging.co.uk'),
              16.verticalSpace,
              CustomPrintForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({super.key, required this.icon, required this.text});
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        8.horizontalSpace,
        AppStyles.normalBoldText(text),
      ],
    );
  }
}

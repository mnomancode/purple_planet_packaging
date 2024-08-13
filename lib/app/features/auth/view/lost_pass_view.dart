import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';
import 'package:purple_planet_packaging/app/features/auth/repository/auth_repository_impl.dart';

import '../../../commons/ppp_app_bar.dart';
import '../../../core/utils/app_images.dart';

class LostView extends ConsumerWidget {
  const LostView({super.key});

  static const routeName = 'lost-password';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const PPPAppBar(title: 'Forgot Password?'),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          children: [
            30.verticalSpace,
            Center(child: Image.asset(AppImages.pppIcon, width: 0.8.sw)),
            50.verticalSpace,
            RichText(
              text: TextSpan(
                  text: 'Lost your password?',
                  style: AppStyles.mediumStyle(color: AppColors.primaryColor),
                  children: [
                    TextSpan(
                        text: ' Enter your email address below and we will send you a link to reset your password.',
                        style: AppStyles.mediumStyle(color: AppColors.blackColor)),
                  ]),
            ),
            20.verticalSpace,
            TextField(
                decoration: InputDecoration(
              hintText: '',
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(AppImages.svgEmail, width: 20, height: 20),
              ),
            )).withLabel('Username or Email address'),
            30.verticalSpace,
            ElevatedButton(
              onPressed: () =>
                  ref.read(authRepositoryProvider).lostPassword(userLogin: 'chnoman503@gmail.com').then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${value.response.statusCode} it is a success'),
                ));
              }),
              child: Text(
                'Reset password',
                style: AppStyles.mediumBoldStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

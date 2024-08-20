import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';
import 'package:purple_planet_packaging/app/features/auth/repository/auth_repository_impl.dart';

import '../../../commons/ppp_app_bar.dart';
import '../../../core/utils/app_images.dart';
import '../model/auth_result.dart';
import '../providers/auth_state_notifier.dart';
import '../providers/login_form_notifier.dart';

class LostView extends HookConsumerWidget {
  const LostView({super.key});

  static const routeName = 'lost-password';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();

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
            TextFormField(
                    controller: nameController,
                    onChanged: (value) => ref.read(loginFormNotifierProvider.notifier).setEmail(value),
                    decoration: InputDecoration(
                      hintText: 'Username or Email address',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(AppImages.svgEmail, width: 20, height: 20),
                      ),
                    ))
                .withLabel('Username or Email address',
                    errorMessage: ref.watch(loginFormNotifierProvider).form.email.errorMessage),
            50.verticalSpace,
            Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final field = ref.watch(loginFormNotifierProvider).form;

              bool isDisabled = !(field.email.isValid);

              return ElevatedButton(
                onPressed: isDisabled
                    ? null
                    : () async {
                        final response =
                            await ref.read(authStateNotifierProvider.notifier).forgotPassword(nameController.text);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
                      },
                child: Text(
                  'Reset password',
                  style: AppStyles.mediumBoldStyle(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

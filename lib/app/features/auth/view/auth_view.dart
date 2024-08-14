import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/loading/loading_screen.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_state_notifier.dart';
import 'package:purple_planet_packaging/app/features/auth/view/lost_pass_view.dart';
import 'package:purple_planet_packaging/app/features/home/view/home_view.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../model/auth_result.dart';
import '../providers/login_form_notifier.dart';

class AuthView extends HookConsumerWidget {
  const AuthView({super.key});

  static const routeName = '/my-account';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authStateNotifierProvider);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              0.1.sh.verticalSpace,
              Center(child: Image.asset(AppImages.pppIcon, width: 0.8.sw)),
              20.verticalSpace,
              Center(child: Text(authController.isNewUser ? 'REGISTER' : 'LOGIN', style: AppStyles.largeStyle())),
              50.verticalSpace,
              Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final emailField = ref.watch(loginFormNotifierProvider).form.email;

                return TextFormField(
                    controller: emailController,
                    onChanged: (value) => ref.read(loginFormNotifierProvider.notifier).setEmail(value),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(AppImages.svgEmail),
                      ),
                    )).withLabel('Username or Email address', errorMessage: emailField.errorMessage);
              }),
              20.verticalSpace,
              Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final passwordField = ref.watch(loginFormNotifierProvider).form.password;
                return TextFormField(
                    controller: passwordController,
                    onChanged: (value) => ref.read(loginFormNotifierProvider.notifier).setPassword(value),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(AppImages.svgEyeOff),
                      ),
                    )).withLabel('Password', errorMessage: passwordField.errorMessage);
              }),
              if (!authController.isNewUser) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.goNamed(LostView.routeName);
                      },
                      child: Text('Forgot Password?', style: AppStyles.boldStyle(color: AppColors.secondaryColor)),
                    ),
                  ],
                ),
              ],
              if (authController.isNewUser) ...[
                20.verticalSpace,
                TextFormField(
                    // controller: confirmPasswordController,
                    decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(AppImages.svgEyeOn),
                  ),
                )).withLabel('Confirm Password'),
                20.verticalSpace,
              ],
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(authController.isNewUser ? 'Already have an account?' : 'Don\'t have an account?',
                      style: AppStyles.mediumStyle()),
                  TextButton(
                    onPressed: ref.read(authStateNotifierProvider.notifier).toggleIsNewUser,
                    child: Text(!authController.isNewUser ? 'Register' : 'Sign In',
                        style: AppStyles.boldStyle(color: AppColors.secondaryColor)),
                  ),
                ],
              ),
              50.verticalSpace,
              Center(
                child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final field = ref.watch(loginFormNotifierProvider).form;

                  bool isDisabled = !(field.email.isValid && field.password.isValid);

                  return ElevatedButton(
                    onPressed: isDisabled
                        ? null
                        : () async {
                            final authState = await ref
                                .read(authStateNotifierProvider.notifier)
                                .login(emailController.text, passwordController.text);

                            if (authState.result != AuthResult.success) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(authState.message ?? 'hello')));
                              return;
                            }

                            context.goNamed(HomeView.routeName);
                          },
                    child: Text(authController.isNewUser ? 'Register' : 'Sign In', style: AppStyles.boldStyle()),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ref.read(authStateNotifierProvider.notifier).login('chnoman503', '1234567');
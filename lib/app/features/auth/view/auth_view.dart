import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_providers.dart';
import 'package:purple_planet_packaging/app/features/auth/repository/auth_repository_impl.dart';
import 'package:purple_planet_packaging/app/features/auth/view/lost_pass_view.dart';

import '../../../commons/elevated_button.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../home/view/home_view.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  static const routeName = '/my-account';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isRegistering = ref.watch(authProvider).isRegistering;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await ref.watch(authRepositoryProvider).getUser(name: 'chnoman503', pass: '1234567');
          log(data.token);
        },
        child: const Text('Dummy'),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppStyles.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              0.15.sh.verticalSpace,
              Center(child: Image.asset(AppImages.pppIcon, width: 0.8.sw)),
              30.verticalSpace,
              Center(child: Text('LOGIN', style: AppStyles.largeStyle())),
              30.verticalSpace,
              TextField(
                  decoration: InputDecoration(
                hintText: '',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SvgPicture.asset(AppImages.svgEmail),
                ),
              )).withLabel('Username or Email address'),
              20.verticalSpace,
              TextField(
                  decoration: InputDecoration(
                hintText: 'Enter your password',
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SvgPicture.asset(AppImages.svgEyeOff),
                ),
              )).withLabel('Password'),
              if (!isRegistering) ...[
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              if (isRegistering) ...[
                20.verticalSpace,
                TextField(
                    decoration: InputDecoration(
                  hintText: '',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SvgPicture.asset(AppImages.svgEyeOn),
                  ),
                )).withLabel('Confirm Password'),
                20.verticalSpace,
              ],
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(!isRegistering ? 'Don\'t have an account?' : 'Already have an account?',
                      style: AppStyles.mediumStyle()),
                  TextButton(
                    onPressed: () {
                      ref.read(authProvider.notifier).register();
                    },
                    child: Text(!isRegistering ? 'Register' : 'Sign In',
                        style: AppStyles.boldStyle(color: AppColors.secondaryColor)),
                  ),
                ],
              ),
              50.verticalSpace,
              Center(
                child: AppElevatedButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).signIn();
                    context.go(HomeView.routeName);
                  },
                  child: Text('Login', style: AppStyles.boldStyle()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

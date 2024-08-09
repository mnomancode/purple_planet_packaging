// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/profile/view/about_us_view.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account'), centerTitle: true),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          children: [
            16.verticalSpace,
            Center(
                child: CircleAvatar(
              radius: 60.r,
              backgroundColor: AppColors.lightPrimaryColor,
              child: Icon(Icons.person, size: 60.r),
            )),
            32.verticalSpace,
            ListTile(
              title: AppStyles.normalBoldText('Profile'),
              leading: SvgPicture.asset(AppImages.svgEdit),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              onTap: () => context.pushNamed(AboutUsView.routeName),
              title: AppStyles.normalBoldText('About Us'),
              leading: SvgPicture.asset(AppImages.svgInfo),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              title: AppStyles.normalBoldText('Order a Sample'),
              leading: SvgPicture.asset(AppImages.svgIdea),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              title: AppStyles.normalBoldText('Delete Account'),
              leading: SvgPicture.asset(AppImages.svgDelete),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              title: AppStyles.normalBoldText('Logout'),
              leading: SvgPicture.asset(AppImages.svgLogout),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
          ],
        ),
      ),
    );
  }
}

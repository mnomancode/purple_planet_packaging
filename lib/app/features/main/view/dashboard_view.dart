import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({required this.navigationShell, super.key});
  final StatefulNavigationShell navigationShell;

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          // elevation: 1,
          showUnselectedLabels: true,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.greyColor,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          type: BottomNavigationBarType.fixed,
          currentIndex: navigationShell.currentIndex,
          onTap: (int index) => _onTap(context, index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.svgHome),
                activeIcon: SvgPicture.asset(AppImages.svgHomeSelected),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.svgShop),
                activeIcon: SvgPicture.asset(AppImages.svgShopSelected),
                label: 'Shop'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.svgCart),
                activeIcon: SvgPicture.asset(AppImages.svgCartSelected),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.svgUser),
                activeIcon: SvgPicture.asset(AppImages.svgUserSelected),
                label: 'Account'),
          ],
        ),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
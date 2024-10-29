import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/features/auth/view/auth_view.dart';
import 'package:purple_planet_packaging/app/features/home/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Image.asset(AppImages.pppLogo),
        ),
      ),
    );
  }

  void _gotoNextScreen() {
    Future.delayed(const Duration(seconds: 1)).then((value) => GoRouter.of(context).go(HomeView.routeName));
  }
}

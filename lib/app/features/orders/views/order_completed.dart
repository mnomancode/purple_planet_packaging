import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/cart/view/cart_view.dart';

import '../../home/view/home_view.dart';

class OrderCompleteView extends StatefulWidget {
  const OrderCompleteView({super.key});

  static const routeName = 'order-completed';

  @override
  State<OrderCompleteView> createState() => OrderCompleteViewState();
}

class OrderCompleteViewState extends State<OrderCompleteView> {
  @override
  void initState() {
    _gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          100.verticalSpace,
          Center(child: Lottie.asset(AppImages.done3Lottie)),
          Text('Your order is complete', style: AppStyles.largeStyle()),
          50.verticalSpace,
          Text('Your order has been placed and will be shipped soon', style: AppStyles.mediumBoldStyle()),
        ],
      ),
    );
  }

  void _gotoNextScreen() {
    Future.delayed(const Duration(milliseconds: 3000)).then((value) => Navigator.of(context).pop());
  }
}

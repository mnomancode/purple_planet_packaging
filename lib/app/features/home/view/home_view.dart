import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/categories_section.dart';
import '../widget/custom_print_sample_buttons.dart';
import '../widget/featured_products.dart';
import '../widget/home_app_bar.dart';
import '../widget/order_by_widget_home.dart';
import '../widget/responsible_packaging.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            5.verticalSpace,
            const ResponsiblePackaging(),
            16.verticalSpace,
            const OrderByWidgetHome(),
            16.verticalSpace,
            const CategoriesSection(),
            16.verticalSpace,
            const CustomPrintSampleButtons(),
            16.verticalSpace,
            const FeaturedProductsSection(title: 'Popular Products'),
          ],
        ),
      ),
    );
  }
}

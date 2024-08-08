import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/categories_section.dart';
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
            const ResponsiblePackaging(),
            16.verticalSpace,
            const OrderByWidgetHome(),
            16.verticalSpace,
            const CategoriesSection(),
            16.verticalSpace,
            const FeaturedProducts(
              title: 'Popular Products',
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }
}

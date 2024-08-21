import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/auth/repository/auth_repository_impl.dart';
import 'package:purple_planet_packaging/app/provider/http_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(authRepositoryProvider).getCart(
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3B1cnBsZXBsYW5ldHBhY2thZ2luZy5jby51ayIsImlhdCI6MTcyNDE3MTMzOSwibmJmIjoxNzI0MTcxMzM5LCJleHAiOjE3MjQxNzE5MzksImRhdGEiOnsidXNlciI6eyJpZCI6NjAwMywiZGV2aWNlIjoiIiwicGFzcyI6ImQxZGVkZTM5NDU0NTA3NWExZjQ5Y2I2OGZhN2ZmNDI3In19fQ.4RIJb45KSi_f5mR52N_RhRCU2Tg9GV6_xlsNp9nNPp8');
        },
        child: const Icon(Icons.add),
      ),
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

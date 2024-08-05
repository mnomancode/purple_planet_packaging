import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/shop_by_category_tab.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/shop_by_food_tab.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';

class ShopTabsSection extends StatefulWidget {
  const ShopTabsSection({super.key});

  @override
  State<ShopTabsSection> createState() => _ShopTabsSectionState();
}

class _ShopTabsSectionState extends State<ShopTabsSection> with AutomaticKeepAliveClientMixin<ShopTabsSection> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
          bottom: TabBar(
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(10.0.r), color: AppColors.primaryColor),
            splashBorderRadius: BorderRadius.circular(10.0.r),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.white,
            labelStyle: AppStyles.mediumBoldStyle(color: AppColors.white),
            unselectedLabelColor: AppColors.primaryColor,
            unselectedLabelStyle: AppStyles.mediumStyle(),
            indicatorPadding: const EdgeInsets.all(4),
            tabs: const [
              Tab(text: 'Shop by Category'),
              Tab(text: 'Shop by Food Type'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ShopByCategory(key: PageStorageKey('ShopByCategory')),
            ShopByFood(key: PageStorageKey('ShopByFoodType')),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/shop_tabs_section.dart';

import '../../../core/utils/app_styles.dart';
import '../widget/shop_app_bar.dart';

class ShopView extends ConsumerWidget {
  const ShopView({Key? key}) : super(key: key);

  static const routeName = '/shop';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const ShopAppBar(),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: const ShopTabsSection(),
      ),
    );
  }
}

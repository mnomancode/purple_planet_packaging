import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/elevated_button_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_details/images_slider.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_price_widget.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';

import '../../../../commons/price_widget.dart';
import '../../../cart/providers/cart_providers.dart';

class ProductDetailsView extends ConsumerWidget {
  const ProductDetailsView({super.key, required this.title, required this.product});

  static const routeName = '/productDetails';
  final String title;
  final ProductsModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PPPAppBar(title: title),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagesSliderView(images: product.images!.map((e) => e.src).toList()),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Text(
                    product.name,
                    style: AppStyles.mediumBoldStyle(fontSize: 16.sp),
                  )),
                ],
              ),
              10.verticalSpace,
              Row(
                children: [
                  Text('Price: ', style: AppStyles.boldStyle()),
                  5.horizontalSpace,
                  ProductPriceWidget(product.prices),
                ],
              ),
              10.verticalSpace,
              const Divider(color: AppColors.primaryColor),
              Text('Description', style: AppStyles.mediumBoldStyle()),
              // HtmlWidget(product.shortDescription ?? ""),
              10.verticalSpace,
              HtmlWidget(product.description!),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => ref.read(newCartNotifierProvider.notifier).addToCart(productId: product.id),
                      child: const Text("Add to Cart"),
                    ).alterP(isTransparent: true),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Buy Now"),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              // const FeaturedProducts(title: 'You might also like', padding: EdgeInsets.zero, leftMargin: 0),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/elevated_button_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';
import 'package:purple_planet_packaging/app/features/shop/notifiers/product_by_id_provider.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_details/images_slider.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_price_widget.dart';

import '../../../../models/products/product.dart';
import '../../notifiers/product_state.dart';
import 'product_varients.dart';
import 'related_products.dart';

class ProductDetailsView extends ConsumerStatefulWidget {
  const ProductDetailsView({super.key, required this.title, required this.product});

  static const routeName = '/productDetails';
  final String title;
  final Product product;

  @override
  ConsumerState<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ConsumerState<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(selectedProductVariantNotifierProvider(defaultProduct: widget.product));
    final state = ref.watch(selectedProductVariantNotifierProvider(defaultProduct: widget.product));

    return Scaffold(
      appBar: PPPAppBar(title: widget.title),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagesSliderView(images: widget.product.images.map((e) => e.src).toList()),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Text(
                    state!.name,
                    style: AppStyles.mediumBoldStyle(fontSize: 14.sp),
                  )),
                ],
              ),
              10.verticalSpace,
              Row(
                children: [
                  Text('Price: ', style: AppStyles.boldStyle()),
                  5.horizontalSpace,
                  ProductPriceWidget(state.price.replaceAll('£', '')),
                ],
              ),
              10.verticalSpace,
              if (widget.product.variations.isNotEmpty) ProductVariantList(product: widget.product),
              Text('Description', style: AppStyles.mediumBoldStyle()),
              10.verticalSpace,
              HtmlWidget(widget.product.description),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.product.stockStatus == StockStatus.outofstock
                          ? null
                          : () {
                              final productId = ref.read(newCartNotifierProvider.notifier).getDefaultProductId(state);

                              ref
                                  .read(newCartNotifierProvider.notifier)
                                  .addToCart(productId: productId, context: context);
                            },
                      child: Text("Add to Cart", style: AppStyles.mediumBoldStyle()),
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ),
              20.verticalSpace,
              RelatedProductsWidget(widget.product.relatedIds),
            ],
          ),
        ),
      ),
    );
  }
}

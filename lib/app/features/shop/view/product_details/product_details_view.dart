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
import 'package:purple_planet_packaging/app/features/shop/widget/product_details/images_slider.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_price_widget.dart';

import '../../../../models/products/product.dart';
import '../../notifiers/product_state.dart';

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
    final state = ref.watch(productNotifierProvider(widget.product));
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
                    widget.product.name,
                    style: AppStyles.mediumBoldStyle(fontSize: 16.sp),
                  )),
                ],
              ),
              10.verticalSpace,

              Row(
                children: [
                  Text('Price: ', style: AppStyles.boldStyle()),
                  5.horizontalSpace,
                  ProductPriceWidget(state.selectedPrice.replaceAll('£', '')),
                ],
              ),
              10.verticalSpace,
              const Divider(color: AppColors.primaryColor),
              10.verticalSpace,
              if (widget.product.variations.isNotEmpty)
                ...widget.product.attributes.first.options!
                    .map((e) => RadioListTile.adaptive(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          groupValue: state.selectedAttributeOption,
                          title: Text(e, style: AppStyles.mediumStyle()),
                          value: e,
                          onChanged: (value) {
                            ref
                                .read(productNotifierProvider(widget.product).notifier)
                                .updateSelectedOption(option: value!);
                          },
                        ))
                    .toList(),

              Text('Description', style: AppStyles.mediumBoldStyle()),
              10.verticalSpace,
              HtmlWidget(widget.product.description),

              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.defaultVariation == null) {
                          log('No default variation');
                          return;
                        }

                        ref.read(newCartNotifierProvider.notifier).addToCart(productId: state.defaultVariation!);
                      },
                      child: Text("Add to Cart", style: AppStyles.mediumBoldStyle()),
                    ).alterP(),
                  ),
                  20.horizontalSpace,
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: Text("Buy Now", style: AppStyles.mediumStyle()),
                  //   ),
                  // ),
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

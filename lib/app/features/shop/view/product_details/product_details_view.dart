import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/elevated_button_extensions.dart';
import 'package:purple_planet_packaging/app/features/shop/widget/product_details/images_slider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/widget/featured_products.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.title, required this.productId});

  static const routeName = 'productDetails';
  final String title;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PPPAppBar(title: title),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ImagesSliderView(
                images: [
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/02/S-Bowl-for-web2.jpg",
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/02/Bowl-Group-for-web.jpg",
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/slid-7x5-1200x1200-25ef164_MEDIUM.jpeg",
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/vegware_concept_square_bowls_salad-1200x1200-b593005_MEDIUM.jpeg",
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/dimensions_slid-7x5p-1200x1200-65a30b9_MEDIUM.jpeg",
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/skc-24_1-1200x1200-551e73c_MEDIUM-750.jpeg",
                  "https://purpleplanetpackaging.co.uk/wp-content/uploads/2024/05/vegware_concept_square_bowls_waffles_2-1200x1200-66c0a9b_MEDIUM.jpeg",
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Planetware™ 8oz Double Wall Takeaway Cup Recyclable/Compostable (Case of 500)",
                    style: AppStyles.mediumBoldStyle(fontSize: 16.sp),
                  )),
                  Text(
                    "£ 10.00",
                    style: AppStyles.largeStyle(),
                  )
                ],
              ),
              20.verticalSpace,
              const HtmlWidget(
                """
               <p>Kraft Salad Bowls are perfect for Hot Food, Salads or Poke. Available with clear microwavable PP air tight lid which will keep your products fresh.</p>\n<div class=\"col-main\">\n<div class=\"product-view\">\n<div class=\"product-collateral\">\n<div class=\"box-collateral box-description\">\n<div class=\"std\">\n<p>Dimensions:</p>\n<p>Capacity: 500ml</p>\n<p>Diameter: 150mm</p>\n<p>Height: 45mm</p>\n<p>Cup Weight: 13.5g</p>\n<p>&nbsp;</p>\n<p>LIDS SOLD SEPARATELY (63000)</p>\n</div>\n</div>\n</div>\n</div>\n</div>\n
                """,
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Add to Cart"),
                    ).alterP(isTransparent: true),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              const FeaturedProducts(title: 'You might also like', padding: EdgeInsets.zero, leftMargin: 0),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_styles.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(this.prices, {super.key, this.columnView = false});
  final Prices prices;
  final bool columnView;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          ...getPriceSpan(includeTax: false),
          if (!columnView) TextSpan(text: ' \n ', style: AppStyles.lightStyle(color: AppColors.greyColor)),
          ...getPriceSpan(includeTax: true),
        ],
        style: AppStyles.largeStyle(),
      ),
    );
  }

  List<InlineSpan> getPriceSpan({bool includeTax = false}) {
    String price;

    if (includeTax) {
      price = prices.regularPrice!.addDecimalFromEnd(prices.currencyMinorUnit!)!.addTwentyPercent();
    } else {
      price = prices.regularPrice!.addDecimalFromEnd(prices.currencyMinorUnit!)!;
    }

    return [
      TextSpan(
        text: '${prices.currencyPrefix} $price ',
        style: AppStyles.largeStyle(
          fontWeight: FontWeight.bold,
          color: includeTax ? AppColors.greyColor : null,
          fontSize: includeTax ? 14.sp : 16.sp,
        ),
      ),
      WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0, 0),
          child: Text(
            includeTax ? 'inc. VAT' : 'exc. VAT  ',
            textScaler: const TextScaler.linear(0.6),
            style: AppStyles.lightStyle(
              fontWeight: includeTax ? null : FontWeight.bold,
              color: includeTax ? AppColors.greyColor : null,
              fontSize: includeTax ? 10.sp : 12.sp,
            ),
          ),
        ),
      )
    ];
  }
}
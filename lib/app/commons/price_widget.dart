// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
// import '../core/utils/app_colors.dart';
// import '../core/utils/app_styles.dart';
// import '../models/cart/cart_model.dart';

// class PriceWidget extends StatelessWidget {
//   const PriceWidget({super.key, this.columnView = false, this.onlyPrice = false});

//   final bool columnView;
//   final bool onlyPrice;

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       textAlign: TextAlign.start,
//       text: TextSpan(
//         children: [
//           ...getPriceSpan(includeTax: false),
//           if (!onlyPrice) ...[
//             if (columnView) TextSpan(text: ' \n ', style: AppStyles.lightStyle(color: AppColors.greyColor)),
//             ...getPriceSpan(includeTax: true),
//           ]
//         ],
//         style: AppStyles.largeStyle(),
//       ),
//     );
//   }

//   List<InlineSpan> getPriceSpan({bool includeTax = false}) {
//     String price;

//     if (includeTax) {
//       price = prices.regularPrice!.addDecimalFromEnd(prices.currencyMinorUnit!)!.addTwentyPercent();
//     } else {
//       price = prices.regularPrice!.addDecimalFromEnd(prices.currencyMinorUnit!)!;
//     }

//     return [
//       TextSpan(
//         text: '${prices.currencyPrefix} $price ',
//         style: AppStyles.largeStyle(
//           fontWeight: FontWeight.bold,
//           color: includeTax ? AppColors.greyColor : null,
//           fontSize: includeTax ? 14.sp : 16.sp,
//         ),
//       ),
//       WidgetSpan(
//         child: Transform.translate(
//           offset: const Offset(0, 0),
//           child: Text(
//             includeTax ? 'inc. VAT' : 'exc. VAT  ',
//             textScaler: const TextScaler.linear(1),
//             textAlign: TextAlign.left,
//             style: AppStyles.lightStyle(
//               fontWeight: includeTax ? null : FontWeight.bold,
//               color: includeTax ? AppColors.greyColor : null,
//               fontSize: includeTax ? 10.sp : 12.sp,
//             ),
//           ),
//         ),
//       )
//     ];
//   }
// }

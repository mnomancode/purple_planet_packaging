// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class CartBottomSheet extends ConsumerWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.scaffoldPadding,
          child: Column(
            children: [
              Text('BASKET TOTALS', style: AppStyles.largeStyle()),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              ...[1, 2, 3, 4]
                  .map((e) => ListTile(
                      minTileHeight: 10,
                      contentPadding: EdgeInsets.zero,
                      title: Text('Item $e', style: AppStyles.mediumStyle()),
                      trailing: Text('£ 200', style: AppStyles.mediumBoldStyle())))
                  .toList(),
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              ...[
                '*Standard Delivery: £7.95',
                '*Next Working Day - Pre noon £15.00/Item: £30.00',
                '*Next Working Day - Pre 10am £25.00/Item: £50.00',
                '*Saturday Delivery £15.00/item: £30.00'
              ]
                  .map((e) => ListTile(
                        minTileHeight: 10,
                        contentPadding: EdgeInsets.zero,
                        leading: Checkbox(value: false, onChanged: (value) {}),
                        title: Text(e, style: AppStyles.mediumStyle()),
                      ))
                  .toList(),
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              AppStyles.normalText('Do you have a promo code?'),
              8.verticalSpace,
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter promo code',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Apply'),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppStyles.mediumBoldStyle()),
                  Text('£ 200', style: AppStyles.mediumBoldStyle()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('VAT', style: AppStyles.mediumBoldStyle()),
                  Text('£ 2.94', style: AppStyles.mediumBoldStyle()),
                ],
              ),
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppStyles.largeStyle()),
                  Text('£ 202.94', style: AppStyles.largeStyle()),
                ],
              ),
              8.verticalSpace,
              ElevatedButton(
                onPressed: () {},
                child: Text('Proceed to Checkout'),
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

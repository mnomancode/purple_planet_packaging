// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/model/shipping_methods.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/shipping_meathods_notifier.dart';

import '../../../core/utils/app_colors.dart';
import '../notifiers/cart_notifier.dart';

class CartBottomSheet extends ConsumerWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(newCartNotifierProvider.notifier).getShippingMethod();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.scaffoldPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BASKET TOTALS', style: AppStyles.largeStyle()),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              ...ref.watch(newCartNotifierProvider).when(data: (data) {
                return data.items!
                    .map((e) => ListTile(
                        minTileHeight: 10,
                        contentPadding: EdgeInsets.zero,
                        title: Text('Item ${e.name}', style: AppStyles.mediumStyle()),
                        trailing: Text('=${e.totals?.lineTotal?.addDecimalFromEnd(e.prices!.currencyMinorUnit) ?? 0}',
                            style: AppStyles.mediumBoldStyle())))
                    .toList();
              }, error: (Object error, StackTrace stackTrace) {
                return [Text(error.toString())];
              }, loading: () {
                return [CircularProgressIndicator()];
              }),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              ref.watch(shippingMethodsNotifierProvider).when(
                  data: (data) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data.map((e) {
                          double? shippingCost = ref.read(shippingMethodsNotifierProvider.notifier).getShippingCost(e);

                          return RadioListTile<ShippingMethod>.adaptive(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            value: e,
                            dense: true,
                            groupValue: ref.watch(selectedShippingMethodNotifierProvider),
                            title: Text(e.settings.title.value + (shippingCost != null ? ' : ($shippingCost)' : ''),
                                style: AppStyles.mediumBoldStyle()),
                            onChanged:
                                ref.read(selectedShippingMethodNotifierProvider.notifier).setSelectedShippingMethod,
                          );
                        }).toList(),
                      ),
                  error: (Object error, StackTrace stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () {
                    return CircularProgressIndicator(color: AppColors.greyColor);
                  }),
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
                      child: Text('Apply', style: AppStyles.mediumBoldStyle()),
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              ref.watch(newCartNotifierProvider).when(
                    data: (data) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: AppStyles.mediumBoldStyle()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '£ ${data.cartTotals!.totalItems?.addDecimalFromEnd(data.cartTotals?.currencyMinorUnit ?? 0) ?? '0.00'}',
                                style: AppStyles.mediumBoldStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('VAT', style: AppStyles.mediumBoldStyle()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${(data.cartTotals?.currencySymbol ?? '£')} ${data.cartTotals!.totalItemsTax?.addDecimalFromEnd(data.cartTotals?.currencyMinorUnit) ?? 0.0}',
                                style: AppStyles.mediumBoldStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal', style: AppStyles.largeStyle()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                '£ ${data.cartTotals?.totalPrice?.addDecimalFromEnd(data.cartTotals?.currencyMinorUnit)?.addShippingCharge(ref.watch(selectedShippingMethodNotifierProvider.notifier).getShippingCost())}',
                                style: AppStyles.largeStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
              8.verticalSpace,

              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              // // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('VAT', style: AppStyles.mediumBoldStyle()),
              //     Text('£ 2.94', style: AppStyles.mediumBoldStyle()),
              //   ],
              // ),
              // Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('Total', style: AppStyles.largeStyle()),
              //     Text('£ 202.94', style: AppStyles.largeStyle()),
              //   ],
              // ),
              8.verticalSpace,
              ElevatedButton(
                onPressed: () {},
                child: Text('Proceed to Checkout', style: AppStyles.mediumBoldStyle()),
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

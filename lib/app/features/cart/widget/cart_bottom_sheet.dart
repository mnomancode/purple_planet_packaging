// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
import 'package:purple_planet_packaging/app/features/orders/notifiers/orders_notifier.dart';
import 'package:purple_planet_packaging/app/models/cart/cart_model.dart';

import '../notifiers/cart_notifier.dart';
import 'shipping_meathods_widget.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BASKET TOTALS', style: AppStyles.largeStyle()),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              ref.watch(newCartNotifierProvider).when(data: (data) {
                if (data.items == null || data.items!.isEmpty) {
                  return const Center(child: Text('Cart is empty'));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...data.items!
                        .map((e) => ListTile(
                            minTileHeight: 10,
                            contentPadding: EdgeInsets.zero,
                            title: Text('Item ${e.name}', style: AppStyles.mediumStyle()),
                            trailing: Text(
                              '£ ${e.totals.total}',
                            )))
                        .toList(),
                    if (data.shipping.rates.isNotEmpty)
                      Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
                    ShippingMethodsWidget(rates: data.shipping.rates),

                    // ...data.shipping.rates.map((e) => RadioListTile<Rate>.adaptive(
                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    //     value: e,
                    //     dense: true,
                    //     groupValue: e,
                    //     title: Text(e.html, style: AppStyles.mediumBoldStyle()),
                    //     onChanged: (_) {}
                    //     // ref.read(selectedShippingMethodNotifierProvider.notifier).setSelectedShippingMethod,
                    //     )),

                    // if (data.shippingRates != null && data.shippingRates!.isNotEmpty)
                    //   ...data.shippingRates!.first.shippingRates.map((e) => RadioListTile<ShippingRate>.adaptive(
                    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    //         value: e,
                    //         dense: true,
                    //         groupValue: ref.watch(selectedShippingMethodNotifierProvider),
                    //         title: Text('${e.name} : ${e.formattedPrice}', style: AppStyles.mediumBoldStyle()),
                    //         onChanged:
                    //             ref.read(selectedShippingMethodNotifierProvider.notifier).setSelectedShippingMethod,
                    //       )),
                  ],
                );
              }, error: (Object error, StackTrace stackTrace) {
                return Text(error.toString());
              }, loading: () {
                return CircularProgressIndicator();
              }),
              8.verticalSpace,
              // Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              // 8.verticalSpace,
              // Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              // 8.verticalSpace,
              // AppStyles.normalText('Do you have a promo code?'),
              // 8.verticalSpace,
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 4,
              //       child: TextField(
              //         decoration: InputDecoration(
              //           hintText: 'Enter promo code',
              //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              //         ),
              //       ),
              //     ),
              //     8.horizontalSpace,
              //     Expanded(
              //       flex: 2,
              //       child: ElevatedButton(
              //         onPressed: () {
              //           ref.read(newCartNotifierProvider.notifier).applyCoupon(code: 'grab24');
              //         },
              //         child: Text('Apply', style: AppStyles.mediumBoldStyle()),
              //       ),
              //     ),
              //   ],
              // ),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              ref.watch(newCartNotifierProvider).when(
                    data: (data) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal', style: AppStyles.mediumBoldStyle()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '£ ${data.totals.subtotal.addDecimalFromEnd()}',
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
                                '£ ${data.totals.subtotalTax.addDecimalFromEnd()}',
                                style: AppStyles.mediumBoldStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: AppStyles.largeStyle()),
                            Text(
                              '£ ${data.totals.total.addDecimalFromEnd()}',
                              style: AppStyles.largeStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
              8.verticalSpace,
              Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
              8.verticalSpace,
              ElevatedButton(
                onPressed: () async {
                  await ref.read(ordersNotifierProvider.notifier).newOrder(context);
                },
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

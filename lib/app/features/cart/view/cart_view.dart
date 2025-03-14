import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/extensions/elevated_button_extensions.dart';
import 'package:purple_planet_packaging/app/extensions/string_extensions.dart';
import 'package:purple_planet_packaging/app/features/cart/notifiers/cart_notifier.dart';

import 'package:purple_planet_packaging/app/features/cart/widget/cart_app_bar.dart';
import 'package:purple_planet_packaging/app/features/cart/widget/cart_bottom_sheet.dart';
import 'package:purple_planet_packaging/app/features/cart/widget/cart_item.dart';
import 'package:purple_planet_packaging/app/features/shop/view/shop_view.dart';
import 'package:purple_planet_packaging/app/models/cart/cart_model.dart';

import '../../../core/utils/app_styles.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CartAppBar(),
      bottomSheet: Container(
        padding: AppStyles.scaffoldPadding,
        height: 170.h,
        child: Column(
          children: [
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
                      const Divider(thickness: 1, color: Colors.grey, endIndent: 10, indent: 10),
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
                      8.verticalSpace,
                      ElevatedButton(
                          onPressed: data.itemCount == 0
                              ? null
                              : () async {
                                  showModalBottomSheet(
                                      context: context,
                                      isDismissible: true,
                                      showDragHandle: true,
                                      enableDrag: true,
                                      scrollControlDisabledMaxHeightRatio: 0.7,
                                      builder: (context) {
                                        return const CartBottomSheet();
                                      });
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImages.svgCart,
                                  colorFilter: data.itemCount == 0
                                      ? null
                                      : const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                              8.horizontalSpace,
                              Text('Proceed to checkout',
                                  style: AppStyles.mediumBoldStyle(
                                      color: data.itemCount == 0 ? AppColors.darkGrey : null)),
                            ],
                          )),
                    ],
                  ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: SvgPicture.asset(AppImages.svgCart, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      //   label: Text('Check-out', style: AppStyles.mediumBoldStyle()),
      //   onPressed: () async {
      //     showModalBottomSheet(
      //         context: context,
      //         isDismissible: true,
      //         showDragHandle: true,
      //         enableDrag: true,
      //         scrollControlDisabledMaxHeightRatio: 0.7,
      //         builder: (context) {
      //           return const CartBottomSheet();
      //         });
      //   },
      // ),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ref.watch(newCartNotifierProvider).when(
                  data: (data) {
                    if (data.items == null || data.items!.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          0.2.sh.verticalSpace,
                          SvgPicture.asset(AppImages.svgCartEmpty, height: 80.h),
                          const Text('Your cart is empty'),
                          16.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: ElevatedButton(
                                onPressed: () => context.pushNamed(ShopView.routeName),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppImages.svgCart,
                                        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)),
                                    8.horizontalSpace,
                                    Text('Go Shopping', style: AppStyles.mediumBoldStyle()),
                                  ],
                                )).alterP(isTransparent: true),
                          )
                        ],
                      );
                    }

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 140),
                        child: ListView.builder(
                          itemCount: data.items?.length,
                          itemBuilder: (context, index) {
                            final cartItem = data.items?[index];
                            if (cartItem == null) {
                              return const SizedBox.shrink();
                            }

                            return CartItemWidget(item: cartItem);
                          },
                        ),
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Text('$error'),
                )
          ],
        ),
      ),
    );
  }
}

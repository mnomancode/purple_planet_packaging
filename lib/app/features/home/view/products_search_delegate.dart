import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/shop/notifiers/shop_notifier.dart';
import 'package:purple_planet_packaging/app/models/products/products.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../shop/view/product_details/product_details_view.dart';

class ProductsSearchDelegate extends SearchDelegate<ProductsModel?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: AppColors.primaryColor),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Lottie.asset(AppImages.searchLottie, width: 150.w),
      );
    }

    FocusScope.of(context).unfocus();
    ScrollController scrollController = ScrollController();

    return Consumer(
      builder: (context, ref, child) {
        var products = ref.watch(searchProductsNotifierProvider(query: query));

        scrollController.addListener(() {
          if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
            products = ref.watch(searchProductsNotifierProvider(query: query));
            log('load more');
          }
        });

        return products.when(
          data: (data) => Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: ListView.builder(
                controller: scrollController,
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      // onTap: () => close(context, data[index]),
                      onTap: () => context.pushNamed(
                        ProductDetailsView.routeName,
                        pathParameters: {'title': data[index].name},
                        extra: data[index],
                      ),
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CachedNetworkImage(
                              imageUrl: data[index].images?.first.src ?? '',
                              fit: BoxFit.contain,
                              height: 57.r,
                              width: 57.r,
                            )),
                      ),
                      title: Text(data[index].name, style: AppStyles.mediumBoldStyle()),
                    )),
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AppImages.searchLottie, width: 150.w),
              Text('Loading...', style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor))
            ],
          )),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // if (query.isEmpty) {
    return Center(
      child: Lottie.asset(AppImages.searchLottie, width: 150.w),
    );
    // }

    // return Consumer(
    //   builder: (context, ref, child) {
    //     final products = ref.watch(searchProductsNotifierProvider(query: query));

    //     return products.when(
    //       data: (data) => ListView.builder(
    //         itemCount: data.length,
    //         itemBuilder: (context, index) => Text(data[index].name),
    //       ),
    //       error: (error, stackTrace) => Text(error.toString()),
    //       loading: () => const Center(child: CircularProgressIndicator()),
    //     );
    //   },
    // );
  }

  void _refetchProducts(WidgetRef ref) {
    log('refetching');
  }
}

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

    return _buildResults(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query.length < 3) {
      return Center(
        child: Lottie.asset(AppImages.searchLottie, width: 150.w),
      );
    }

    return _buildResults(context, query);
  }
}

Widget _buildResults(BuildContext context, String query) {
  return Consumer(
    builder: (context, ref, child) {
      ScrollController scrollController = ScrollController();
      final data = ref.watch(searchProductsNotifierProvider(query));
      final isLoading = ref.watch(searchProductsNotifierProvider(query)).value?.isLoading ?? false;

      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          ref.read(searchProductsNotifierProvider(query).notifier).loadMore(query: query);
        }
      });

      return data.when(
        data: (data) {
          return Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: data.products.isEmpty && !isLoading
                ? const Center(child: Text('No Products Found'))
                : ListView.builder(
                    controller: scrollController,
                    itemCount: data.products.length,
                    itemBuilder: (context, index) {
                      if (isLoading && index == data.products.length - 1) {
                        return const Center(child: LinearProgressIndicator());
                      }

                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        // onTap: () => close(context, data[index]),
                        onTap: () => context.pushNamed(
                          ProductDetailsView.routeName,
                          pathParameters: {'title': data.products[index].name},
                          extra: data.products[index],
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.primaryColor),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CachedNetworkImage(
                                imageUrl: data.products[index].images?.first.src ?? '',
                                fit: BoxFit.contain,
                                height: 57.r,
                                width: 57.r,
                              )),
                        ),
                        title: Text(data.products[index].name, style: AppStyles.mediumBoldStyle()),
                      );
                    }),
          );
        },
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

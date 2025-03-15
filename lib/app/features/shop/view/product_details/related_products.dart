import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../commons/product_list_item.dart';
import '../../../../core/utils/app_styles.dart';
import '../../notifiers/product_by_id_provider.dart';

class RelatedProductsWidget extends ConsumerWidget {
  const RelatedProductsWidget(this.relatedProducts, {super.key});

  final List<int> relatedProducts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 350.h,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Related Products', style: AppStyles.mediumBoldStyle(color: AppColors.primaryColor, fontSize: 16.sp)),
        8.verticalSpace,
        SizedBox(
          height: 280.h,
          child: ListView.separated(
              shrinkWrap: true,
              cacheExtent: 1000,
              scrollDirection: Axis.horizontal,
              itemCount: relatedProducts.length,
              separatorBuilder: (context, index) => 10.horizontalSpace,
              itemBuilder: (context, index) => ref.watch(productByVariantProvider(relatedProducts[index])).when(
                    data: (data) {
                      return ProductListItem(product: data);
                    },
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => SizedBox(
                      height: 280.h,
                      width: 210.w,
                      child: Skeletonizer.zone(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Bone.square(size: 130.h, borderRadius: BorderRadius.circular(10)),
                                10.verticalSpace,
                                const Bone.multiText(lines: 3),
                                5.verticalSpace,
                                const Bone.multiText(lines: 2),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
        ),
        20.verticalSpace
      ]),
    );
  }
}

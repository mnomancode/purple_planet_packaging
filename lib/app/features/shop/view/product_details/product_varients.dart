import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/models/products/product.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../notifiers/product_by_id_provider.dart';

class ProductVariantList extends ConsumerStatefulWidget {
  final Product product;

  const ProductVariantList({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductVariantList> createState() => _ProductVariantListState();
}

class _ProductVariantListState extends ConsumerState<ProductVariantList> {
  @override
  Widget build(BuildContext context) {
    final selectedVariant = ref.watch(selectedProductVariantNotifierProvider(defaultProduct: widget.product));
    return Column(
      children: [
        const Divider(color: AppColors.primaryColor),
        10.verticalSpace,
        SizedBox(
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Variant: ', style: AppStyles.boldStyle()),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.product.variations.map((variant) {
                  return ref.watch(productByVariantProvider(variant)).when(
                        data: (data) => ChoiceChip(
                            elevation: 2,
                            pressElevation: 5,
                            label: Text('${data.attributes.first.option}'),
                            selected: data.id == (selectedVariant?.id ?? 0),
                            onSelected: (selected) {
                              ref
                                  .read(selectedProductVariantNotifierProvider(defaultProduct: widget.product).notifier)
                                  .selectVariant(data);
                            }),
                        error: (error, stack) => Text(error.toString()),
                        loading: () => const Skeletonizer.zone(
                            child: Bone.button(
                          width: 100,
                          height: 40,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                      );
                }).toList(),
              ),
            ],
          ),
        ),
        10.verticalSpace,
        const Divider(color: AppColors.primaryColor),
      ],
    );
  }
}

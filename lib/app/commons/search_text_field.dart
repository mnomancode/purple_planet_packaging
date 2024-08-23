import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_images.dart';
import '../features/home/view/products_search_delegate.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () async {
        // final product =
        await showSearch(
          context: context,
          delegate: ProductsSearchDelegate(),
        );

        // if (product != null) {
        //   context.pushNamed(
        //     ProductDetailsView.routeName,
        //     pathParameters: {'title': product.name},
        //     extra: product,
        //   );
        // }
      },
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Search Products',
        fillColor: AppColors.white,
        filled: true,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 5),
          child: SvgPicture.asset(AppImages.svgSearch),
        ),
      ),
    );
  }
}

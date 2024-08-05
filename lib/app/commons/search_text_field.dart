import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/app_images.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
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

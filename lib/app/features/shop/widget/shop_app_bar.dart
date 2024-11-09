import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/commons/search_text_field.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';

class ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShopAppBar({super.key, this.height = 110});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        title: const Text('Shop'),
        centerTitle: true,
        // actions: [
        //   CircleAvatar(backgroundColor: Colors.white, child: SvgPicture.asset(AppImages.svgFilter)),
        //   20.horizontalSpace,
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: const SearchTextField(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

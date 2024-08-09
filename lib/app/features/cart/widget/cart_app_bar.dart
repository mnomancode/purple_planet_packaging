import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/commons/search_text_field.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key, this.height = 50});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

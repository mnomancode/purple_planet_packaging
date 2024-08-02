import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class PPPAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PPPAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      leadingWidth: 65,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          backgroundColor: AppColors.white,
          child: IconButton(
            icon: SvgPicture.asset(AppImages.svgArrowLeft, width: 35),
            onPressed: Navigator.of(context).pop,
          ),
        ),
      ),
      elevation: 0,
      title: Text(title, style: AppStyles.largeStyle()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

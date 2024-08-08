import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class PPPAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PPPAppBar({super.key, required this.title, this.action, this.automaticallyImplyLeading = true});
  final String title;
  final Widget? action;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 65,
      centerTitle: true,
      leadingWidth: 55,
      leading: automaticallyImplyLeading
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: IconButton(
                  icon: SvgPicture.asset(AppImages.svgArrowLeft, width: 35),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            )
          : null,
      title: Text(title, style: AppStyles.largeStyle(fontSize: 20.sp)),
      actions: [if (action != null) action!, const SizedBox(width: 16)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

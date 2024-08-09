import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/custom_print/model/app_faq_model.dart';

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({super.key, required this.faq});
  final AppFAQ faq;

  @override
  State<AppExpansionTile> createState() => _AppExpansionTileState();
}

class _AppExpansionTileState extends State<AppExpansionTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          trailing:
              isExpanded ? SvgPicture.asset(AppImages.svgArrowForward) : SvgPicture.asset(AppImages.svgArrowForward),
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(
                width: 0.65.sw,
                child: Text(widget.faq.question, style: AppStyles.mediumStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: Text(widget.faq.answer),
            ),
          ],
        ),
      ),
    );
  }
}

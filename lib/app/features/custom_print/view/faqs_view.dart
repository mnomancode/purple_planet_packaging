// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_constants.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

import '../../../commons/expansion_tile.dart';

class FaqsView extends StatelessWidget {
  const FaqsView({super.key});

  static const routeName = 'faqs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PPPAppBar(title: 'FAQs'),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          children: AppConstants.appFaqs.map((faq) => AppExpansionTile(faq: faq)).toList(),
        ),
      ),
    );
  }
}

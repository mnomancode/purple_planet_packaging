// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

import '../widget/order_samples_form.dart';

class OrderSamplesView extends ConsumerWidget {
  const OrderSamplesView({Key? key}) : super(key: key);

  static const routeName = '/orderSamples';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PPPAppBar(title: 'Order Sample'),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    text: 'To order samples, fill out the form below. A charge of ',
                    style: AppStyles.mediumStyle(color: AppColors.blackColor),
                    children: [
                      TextSpan(
                        text: ' £7.95 plus VAT',
                        style: AppStyles.mediumBoldStyle(),
                      ),
                      TextSpan(
                        text:
                            ' will need to be paid in order to send the samples out on a 3-5 day service. Please note we only send 1-2 pieces of each sample that you are interested in',
                        style: AppStyles.mediumStyle(color: AppColors.blackColor),
                      ),
                    ]),
              ),
              16.verticalSpace,
              OrderSampleForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const routeName = 'about-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PPPAppBar(title: 'About Us'),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.scaffoldPadding,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'WHO ARE',
                  style: AppStyles.largeStyle(),
                  children: [
                    TextSpan(
                      text: ' PURPLE PLANET PACKAGING',
                      style: AppStyles.largeStyle(color: AppColors.primaryColor, fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              8.verticalSpace,
              Image.asset(AppImages.about1),
              8.verticalSpace,
              AppStyles.normalText(
                  'Welcome to Purple Planet Packaging. We are a dedicated family-run team that embarked on our journey into the takeaway packaging industry back in 2019. Located in Coventry, we have rapidly emerged as a prominent player in the field of packaging solutions. Our strength lies in offering a comprehensive range of products designed to meet your diverse needs.'),
              8.verticalSpace,
              AppStyles.normalText(
                  'What truly sets Purple Planet Packaging apart is our versatility. We understand that businesses have varied requirements when it comes to takeaway packaging, and that’s why we cater to a wide spectrum of packaging solutions. We are not confined to a single niche – we offer a plethora of options to choose from.'),
              16.verticalSpace,
              RichText(
                text: TextSpan(
                  text: 'WHY CHOOSE',
                  style: AppStyles.largeStyle(),
                  children: [
                    TextSpan(
                      text: ' PURPLE PLANET PACKAGING?',
                      style: AppStyles.largeStyle(color: AppColors.primaryColor, fontSize: 20.sp),
                    ),
                  ],
                ),
              ),
              8.verticalSpace,
              Image.asset(AppImages.about2),
              8.verticalSpace,
              AppStyles.normalText(
                  'At Purple Planet Packaging, we acknowledge the importance of sustainable packaging without limiting your choices. We take pride in offering a broad range of products, inviting you to explore packaging solutions that balance quality, durability and value. Our packaging isn’t just about being eco-friendly; it’s about providing you with a diverse set of options to meet your specific needs.'),
              8.verticalSpace,
              AppStyles.normalText(
                  'As a family-run business with substantial experience in catering to the UK food service industry, we have a deep understanding of the unique requirements of various businesses. Whether you run an artisan café, manage an independent street food stall, operate as an outdoor event caterer, or oversee a food festival, we have custom-tailored solutions designed just for you.'),
              8.verticalSpace,
              Image.asset(AppImages.about3),
              8.verticalSpace,
              AppStyles.normalText(
                  'Our range of takeaway packaging encompasses a wide array of materials, including plant-based options such as corn, sugarcane and potatoes. These annually renewable resources allow us to create responsible packaging that serves as an excellent alternative to traditional petroleum-based plastics. We also utilize recyclable materials like PP, r-PET, wood and paper.'),
              8.verticalSpace,
              AppStyles.normalText(
                  'While we are proud of the eco-friendliness of our products, we have evolved to offer more than just compostable packaging. We understand the changing dynamics of businesses, which is why we have expanded our product offerings to cater to various preferences and needs.'),
              16.verticalSpace,
              ElevatedButton(onPressed: () {}, child: Text('Contact Us')),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

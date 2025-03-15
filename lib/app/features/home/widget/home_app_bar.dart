// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:purple_planet_packaging/app/commons/search_text_field.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/auth/view/auth_view.dart';
import 'package:purple_planet_packaging/app/features/profile/view/profile_view.dart';

import '../../../core/utils/app_colors.dart';
import '../../../provider/shared_preferences_storage_service_provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.height = 180});
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      height: height.h,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Column(
        children: [
          32.verticalSpace,
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello,', style: AppStyles.largeStyle(color: AppColors.white)),
                  Consumer(builder: (context, ref, child) {
                    final name = ref.watch(storageServiceProvider).get('name');

                    return FutureBuilder(
                        future: name,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            log(snapshot.error.toString());
                          }
                          return Text('${snapshot.data ?? "Guest User"}',
                              style: AppStyles.largeStyle(color: AppColors.white));
                        });
                  }),
                ],
              ),
              Spacer(),
              Consumer(builder: (context, ref, child) {
                return GestureDetector(
                  onTap: () async {
                    final hasToken = await ref.read(storageServiceProvider).has('token');
                    if (!hasToken) {
                      context.go(AuthView.routeName);
                      return;
                    }

                    context.go(ProfileView.routeName);
                  },
                  child: CircleAvatar(
                      backgroundColor: AppColors.lightGreyColor.withOpacity(0.2),
                      child: SvgPicture.asset(
                        AppImages.svgUser,
                        colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                      )),
                );
              }),
              5.horizontalSpace,
              // GestureDetector(
              //   onTap: () => context.pushNamed(OrderSamplesView.routeName),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SvgPicture.asset(AppImages.svgSampleCart),
              //       3.verticalSpace,
              //       Text('Order\nSample',
              //           style: AppStyles.lightStyle(color: AppColors.white), textAlign: TextAlign.center)
              //     ],
              //   ),
              // ),
              // 5.horizontalSpace,
              // GestureDetector(
              //   onTap: () => context.pushNamed(CustomPrintView.routeName),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SvgPicture.asset(AppImages.svgPrinter),
              //       3.verticalSpace,
              //       Text('Custom\nPrint',
              //           style: AppStyles.lightStyle(color: AppColors.white), textAlign: TextAlign.center)
              //     ],
              //   ),
              // ),
            ],
          ),
          8.verticalSpace,
          SearchTextField()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}



// Dummy code snippet

// DefaultTabController(
//   length: 5,
//   child: Scaffold(
//       body: NestedScrollView(
//     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//       return <Widget>[
//         new SliverAppBar(
//           title: Text('Tabs Demo'),
//           pinned: true,
//           floating: true,
//           bottom: TabBar(
//             isScrollable: true,
//             tabs: [
//               Tab(child: Text('Flight')),
//               Tab(child: Text('Train')),
//               Tab(child: Text('Car')),
//               Tab(child: Text('Cycle')),
//               Tab(child: Text('Boat')),
//             ],
//           ),
//         ),
//       ];
//     },
//     body: TabBarView(
//       children: <Widget>[
//         Icon(Icons.flight, size: 350),
//         Icon(Icons.directions_transit, size: 350),
//         Icon(Icons.directions_car, size: 350),
//         Icon(Icons.directions_bike, size: 350),
//         Icon(Icons.directions_boat, size: 350),
//       ],
//     ),
//   )),
// );
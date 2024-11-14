// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/address/view/billing_address_view.dart';
import 'package:purple_planet_packaging/app/features/address/view/shipping_address_view.dart';
import 'package:purple_planet_packaging/app/features/auth/providers/auth_state_notifier.dart';
import 'package:purple_planet_packaging/app/features/auth/view/auth_view.dart';
import 'package:purple_planet_packaging/app/features/home/view/home_view.dart';
import 'package:purple_planet_packaging/app/features/order_samples/view/order_samples_view.dart';
import 'package:purple_planet_packaging/app/features/profile/view/about_us_view.dart';

import '../../../provider/http_provider.dart';
import '../../../provider/shared_preferences_storage_service_provider.dart';
import '../../auth/repository/auth_repository_impl.dart';
import '../widget/confitmation_dialog.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account'), centerTitle: true),
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          children: [
            16.verticalSpace,
            // Center(
            //     child: Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     CircleAvatar(
            //       radius: 60.r,
            //       backgroundColor: AppColors.lightPrimaryColor,
            //       child: Icon(Icons.person, size: 80.r, color: AppColors.primaryColor),
            //     ),
            //   ],
            // )),
            Lottie.asset('assets/lottie/user.json', width: 120.r, height: 120.r, fit: BoxFit.fill, repeat: false),
            16.verticalSpace,
            Consumer(builder: (context, ref, child) {
              final name = ref.read(storageServiceProvider).get('name');

              return FutureBuilder(
                  future: name,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return Text('${snapshot.data ?? "Guest User"}', style: AppStyles.largeStyle());
                  });
            }),
            32.verticalSpace,
            // ListTile(
            //   title: AppStyles.normalBoldText('Profile'),
            //   leading: SvgPicture.asset(AppImages.svgEdit),
            //   trailing: SvgPicture.asset(AppImages.svgArrowForward),
            // ),
            // Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              onTap: () => context.pushNamed(AboutUsView.routeName),
              title: AppStyles.normalBoldText('About Us'),
              leading: SvgPicture.asset(AppImages.svgInfo),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              onTap: () => context.pushNamed(OrderSamplesView.routeName),
              title: AppStyles.normalBoldText('Order a Sample'),
              leading: SvgPicture.asset(AppImages.svgIdea),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              onTap: () => context.pushNamed(AddressView.routeName, queryParameters: {'isShipping': 'true'}),
              title: AppStyles.normalBoldText('Shipping Address'),
              leading: Icon(Icons.location_on, color: AppColors.primaryColor),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),

            ListTile(
              onTap: () => context.pushNamed(BillingAddressView.routeName),
              title: AppStyles.normalBoldText('Billing Address'),
              leading: Icon(Icons.location_city_outlined, color: AppColors.primaryColor),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
            ListTile(
              onTap: () {
                ref.read(storageServiceProvider).clear();
                context.go(AuthView.routeName);
              },
              title: AppStyles.normalBoldText('Logout'),
              leading: SvgPicture.asset(AppImages.svgLogout),
              trailing: SvgPicture.asset(AppImages.svgArrowForward),
            ),
            Consumer(builder: (context, ref, child) {
              return FutureBuilder(
                  future: ref.read(storageServiceProvider).get('email'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.data == null) return Container();
                    return Column(
                      children: [
                        Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),
                        ListTile(
                          onTap: () async {
                            final email = await ref.read(storageServiceProvider).get('email');

                            showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              builder: (context) {
                                return ConfirmationDialog(
                                  email: '$email',
                                  title: 'Confirm Delete',
                                  content: 'This action will permanently delete your account',
                                  onConfirm: () async {
                                    ref.read(storageServiceProvider).clear();

                                    context.go(AuthView.routeName);
                                  },
                                );
                              },
                            );
                          },
                          title: AppStyles.normalBoldText('Delete Account'),
                          leading: SvgPicture.asset(AppImages.svgDelete),
                          trailing: SvgPicture.asset(AppImages.svgArrowForward),
                        ),
                      ],
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/commons/ppp_app_bar.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/features/custom_print/view/faqs_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../widget/custom_print_main_widget.dart';

class CustomPrintView extends StatefulWidget {
  const CustomPrintView({Key? key}) : super(key: key);

  static const routeName = '/customPrint';

  @override
  State<CustomPrintView> createState() => _CustomPrintViewState();
}

class _CustomPrintViewState extends State<CustomPrintView> {
  late WebViewController controller;
  bool _isLoading = true;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://purpleplanetpackaging.co.uk/custom-print/?accept-cookies'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(),
        body: _isLoading
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Image.asset(AppImages.pppLogo),
                ),
              )
                .animate()
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(delay: 300.ms, duration: 600.ms, curve: Curves.ease) // runs after the above w/new duration
            : WebViewWidget(controller: controller)
        // Padding(
        //   padding: AppStyles.scaffoldPadding,
        //   child: Column(
        //     // ignore: prefer_const_literals_to_create_immutables
        //     children: [
        //       CustomPrintMainWidget(),
        //       16.verticalSpace,
        //       Text(
        //           'Regardless of your company’s size, brand visibility is vital when trying to connect with both new and existing customers. Our custom packaging is the perfect way to build brand awareness, promote your business and show off your unique identity. Stand out from the crowd and let people know who you are.'),
        //       16.verticalSpace,
        //       ListTile(
        //         onTap: () => context.pushNamed(FaqsView.routeName),
        //         title: AppStyles.normalBoldText('FAQs'),
        //         leading: SvgPicture.asset(AppImages.svgInfo),
        //         trailing: SvgPicture.asset(AppImages.svgArrowForward),
        //       ),
        //       Divider(color: AppColors.greyColor, height: 1, endIndent: 20, indent: 20),

        //       32.verticalSpace,

        //       ElevatedButton(onPressed: () {}, child: Text('Get a Quote', style: AppStyles.mediumStyle())),

        //       // const Center(
        //       //   child: Text('Custom Print View'),
        //       // ),
        //     ],
        //   ),
        // ),

        );
  }
}

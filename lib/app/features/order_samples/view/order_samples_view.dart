// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/utils/app_images.dart';

class OrderSamplesView extends StatefulWidget {
  const OrderSamplesView({Key? key}) : super(key: key);

  static const routeName = '/orderSamples';

  @override
  State<OrderSamplesView> createState() => _OrderSamplesViewState();
}

class _OrderSamplesViewState extends State<OrderSamplesView> {
  late WebViewController controller;
  bool _isLoading = true;
  double progress = 0;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print('WebView is loading (progress : $progress%)');
            setState(() {
              this.progress = progress / 100;
            });
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
      ..loadRequest(Uri.parse('https://purpleplanetpackaging.co.uk/samples/?accept-cookies'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Image.asset(AppImages.pppLogo),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: LinearProgressIndicator(value: progress),
                    ),
                    Text('Loading ${progress * 100}%'),
                  ],
                ),
              )
                .animate()
                .fadeIn() // uses `Animate.defaultDuration`
                .scale() // inherits duration from fadeIn
                .move(delay: 300.ms, duration: 600.ms, curve: Curves.ease) // runs after the above w/new duration
            : WebViewWidget(controller: controller)
        // : Padding(
        //     padding: AppStyles.scaffoldPadding,
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           RichText(
        //             text: TextSpan(
        //                 text: 'To order samples, fill out the form below. A charge of ',
        //                 style: AppStyles.mediumStyle(color: AppColors.blackColor),
        //                 children: [
        //                   TextSpan(
        //                     text: ' £7.95 plus VAT',
        //                     style: AppStyles.mediumBoldStyle(),
        //                   ),
        //                   TextSpan(
        //                     text:
        //                         ' will need to be paid in order to send the samples out on a 3-5 day service. Please note we only send 1-2 pieces of each sample that you are interested in',
        //                     style: AppStyles.mediumStyle(color: AppColors.blackColor),
        //                   ),
        //                 ]),
        //           ),
        //           16.verticalSpace,
        //           OrderSampleForm(),
        //         ],
        //       ),
        //     ),
        //   ),
        );
  }
}

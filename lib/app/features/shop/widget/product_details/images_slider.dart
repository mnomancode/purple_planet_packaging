import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ImagesSliderView extends StatefulWidget {
  const ImagesSliderView({super.key, this.portionOfSH = 0.31, required this.images});
  final double? portionOfSH;
  final List<String?> images;

  @override
  State<StatefulWidget> createState() {
    return _ImagesSliderViewState();
  }
}

class _ImagesSliderViewState extends State<ImagesSliderView> {
  int _currentIndex = 0;
  // final List<String> images = [
  //   'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
  //   'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
  //   'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  //   'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
  //   'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
  //   'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  //   'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  // ];

  late final CarouselController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var imageUrl in widget.images) {
        precacheImage(NetworkImage(imageUrl!), context);
      }
    });
    _controller = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.roundBorder,
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      height: widget.portionOfSH?.sh,
      width: 1.sw,
      child: Column(
        children: [
          const Spacer(),
          CarouselSlider.builder(
            itemCount: widget.images.length,
            carouselController: _controller,
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 0.7,
              onPageChanged: (index, reason) => setState(() => _currentIndex = index),
            ),
            itemBuilder: (context, index, realIdx) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.IMAGE_VIEW, arguments: widget.images);
                    // Get.to(() => HeroPhotoViewRouteWrapper(
                    //       imageProvider: CachedNetworkImageProvider(widget.images[index]!),
                    //       tag: widget.images[index]!,
                    //     ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index]!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.images.length,
            effect: const ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 10,
              expansionFactor: 2,
              spacing: 6,
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.lightPrimaryColor,
            ),
            onDotClicked: (index) => setState(() {
              _currentIndex = index;
              _controller.animateToPage(index);
            }),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

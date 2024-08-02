// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';

import '../widget/home_app_bar.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HomeAppBar(
        height: 190.h,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsLoadingGridView extends StatelessWidget {
  const ProductsLoadingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Skeletonizer.zone(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(child: Bone.square(size: 130.h, borderRadius: BorderRadius.circular(10))),
                10.verticalSpace,
                const Bone.multiText(lines: 3),
                5.verticalSpace,
                const Bone.multiText(lines: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
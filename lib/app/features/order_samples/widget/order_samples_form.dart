import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';

class OrderSampleForm extends StatelessWidget {
  const OrderSampleForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your name'),
        ).withLabel('Name'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your Business Name*'),
        ).withLabel('Business Name'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your Email'),
        ).withLabel('Email Address'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your Address'),
          maxLines: 5,
        ).withLabel('Address'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your town address'),
        ).withLabel('Town/City'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your post code e.g 79983'),
        ).withLabel('Postcode'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Country'),
        ).withLabel('Country'),
        8.verticalSpace,
        TextFormField(
          decoration: const InputDecoration(hintText: 'Enter your Message'),
          maxLines: 5,
        ).withLabel('List the SKU items you wish to have samples of'),
        16.verticalSpace,
        ElevatedButton(onPressed: () {}, child: const Text('Order Samples')),
        16.verticalSpace,
      ],
    );
  }
}

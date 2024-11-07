import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_images.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';
import 'package:purple_planet_packaging/app/features/address/providers/notifier/address_notifier.dart';

class BillingAddressView extends ConsumerStatefulWidget {
  const BillingAddressView(this.isShipping, {Key? key}) : super(key: key);
  final bool isShipping;

  static const routeName = '/billing-address';

  @override
  ConsumerState<BillingAddressView> createState() => _BillingAddressViewState();
}

class _BillingAddressViewState extends ConsumerState<BillingAddressView> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postcodeController;
  late TextEditingController _countryController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _postcodeController = TextEditingController();
    _countryController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(billingNotifierProvider);

    return Scaffold(
      body: Padding(
        padding: AppStyles.scaffoldPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.verticalSpace,
              Image.asset(AppImages.pppLogo),
              Text('Billing Address', style: AppStyles.largeStyle()),
              10.verticalSpace,
              state.when(
                data: (shipping) {
                  if (shipping != null) {
                    _firstNameController.text = shipping.firstName;
                    _lastNameController.text = shipping.lastName;
                    _address1Controller.text = shipping.address1;
                    _address2Controller.text = shipping.address2 ?? '';
                    _cityController.text = shipping.city;
                    _stateController.text = shipping.state;
                    _postcodeController.text = shipping.postcode;
                    _countryController.text = shipping.country;
                  }

                  return Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          onChanged: (value) =>
                              ref.read(billingNotifierProvider.notifier).updateField('firstName', value),
                        ).withLabel('First Name'),
                        5.verticalSpace,
                        TextFormField(
                          controller: _lastNameController,
                          onChanged: (value) =>
                              ref.read(billingNotifierProvider.notifier).updateField('lastName', value),
                        ).withLabel('Last Name'),
                        5.verticalSpace,
                        TextFormField(
                          controller: _address1Controller,
                          onChanged: (value) =>
                              ref.read(billingNotifierProvider.notifier).updateField('address1', value),
                        ).withLabel('Address 1'),
                        5.verticalSpace,
                        TextFormField(
                          controller: _address2Controller,
                          onChanged: (value) =>
                              ref.read(billingNotifierProvider.notifier).updateField('address2', value),
                        ).withLabel('Address 2'),
                        5.verticalSpace,
                        TextFormField(
                          controller: _cityController,
                          onChanged: (value) => ref.read(billingNotifierProvider.notifier).updateField('city', value),
                        ).withLabel('City'),
                        5.verticalSpace,
                        TextFormField(
                          controller: _stateController,
                          onChanged: (value) => ref.read(billingNotifierProvider.notifier).updateField('state', value),
                        ).withLabel('State'),
                        5.verticalSpace,
                        TextFormField(
                          controller: _postcodeController,
                          onChanged: (value) =>
                              ref.read(billingNotifierProvider.notifier).updateField('postcode', value),
                        ).withLabel('Postcode'),
                        16.verticalSpace,
                        ElevatedButton(
                          onPressed: () {
                            ref.read(billingNotifierProvider.notifier).saveBilling(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                },
                // } SizedBox(
                //   child: Text('Address View  + ${shipping.toString()}'),
                // ),
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

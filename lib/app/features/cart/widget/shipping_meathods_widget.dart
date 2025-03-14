import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/app_styles.dart';
import '../../../models/cart/cart_model.dart';
import '../notifiers/selected_shipping_provider.dart';

class ShippingMethodsWidget extends ConsumerWidget {
  final List<Rate> rates;

  const ShippingMethodsWidget({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRate = ref.watch(selectedShippingMethodNotifierProvider);

    return Column(
      children: rates.map((e) {
        return RadioListTile<Rate>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          value: e,
          dense: true,
          groupValue: selectedRate, // ✅ Read from the state
          title: Text(e.html, style: AppStyles.mediumBoldStyle()),
          onChanged: (value) {
            ref.read(selectedShippingMethodNotifierProvider.notifier).setSelectedShippingMethod(value);
          },
        );
      }).toList(),
    );
  }
}

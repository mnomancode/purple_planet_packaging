// write code for extension on test field that add the textfield in a column with a label

import 'package:flutter/material.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

extension TextFieldExtension on TextField {
  Widget withLabel(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.mediumBoldStyle()),
        const SizedBox(height: 5),
        this,
      ],
    );
  }
}

extension TextFormFieldExtension on TextFormField {
  Widget withLabel(String label, {String? errorMessage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.mediumBoldStyle()),
        const SizedBox(height: 5),
        this,
        if (errorMessage != null && errorMessage.isNotEmpty)
          Text(errorMessage, style: AppStyles.hintStyle(color: Colors.red)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: AppStyles.buttonStyle,
      child: child,
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';
import 'package:purple_planet_packaging/app/extensions/text_field_extension.dart';

import '../../../core/utils/app_images.dart';
import '../../auth/repository/auth_repository_impl.dart';

class ConfirmationDialog extends ConsumerStatefulWidget {
  final String title;
  final String content;
  final String email;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.email,
    required this.content,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  ConsumerState<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends ConsumerState<ConfirmationDialog> {
  TextEditingController emailController = TextEditingController();
  bool isDisabled = false;
  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppStyles.scaffoldPadding,
        child: Column(
          children: [
            Text(widget.title, style: AppStyles.boldStyle(color: AppColors.primaryColor, fontSize: 16.sp)),
            10.verticalSpace,
            Text(widget.content, style: AppStyles.mediumStyle(color: AppColors.blackColor)),
            20.verticalSpace,
            Text(widget.email, style: AppStyles.largeStyle()),
            10.verticalSpace,
            TextField(
                controller: emailController,
                onChanged: (value) {
                  log(value, name: 'value');
                  if (value.trim() == widget.email) {
                    setState(() {
                      isDisabled = false;
                    });
                  } else {
                    setState(() {
                      isDisabled = true;
                    });
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgPicture.asset(AppImages.svgEyeOff),
                  ),
                )).withLabel('Enter the above email'),
            20.verticalSpace,
            ElevatedButton(
                onPressed: isDisabled
                    ? null
                    : () async {
                        try {
                          isLoading = true;
                          setState(() {});

                          if (emailController.text.trim() != widget.email) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Wrong email'), backgroundColor: Colors.red));
                            return;
                          }

                          final response =
                              await ref.read(authRepositoryProvider).deleteCustomer(name: widget.email, pass: '');

                          if (response?.statusCode == 200) {
                            widget.onConfirm();

                            Navigator.of(context).pop();
                          } else {
                            SnackBar(content: Text(response?.message ?? 'Error'), backgroundColor: Colors.red);
                          }
                        } catch (e) {
                          log('Error ', error: e, stackTrace: (e as Error?)?.stackTrace);
                        } finally {
                          isLoading = false;
                          setState(() {});
                        }
                      },
                child: const Text('Delete Account')),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}

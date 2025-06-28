import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    final color = isSuccess
        ? AppColor.completedButtonColor
        : AppColor.logoutButtonColor;
    final icon = isSuccess ? Icons.check_circle : Icons.error;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColor.textWhite),
            Gap.gapH16,
            Expanded(
              child: Text(
                message,
                style: AppTextStyle.sfProW60014.copyWith(
                  color: AppColor.textWhite,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

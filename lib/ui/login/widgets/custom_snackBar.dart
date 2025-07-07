import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message, // message text
    required bool isSuccess, // success or error type
  }) {
    final color = isSuccess
        ? AppColor.completedButtonColor
        : AppColor.logoutButtonColor; // background color
    final icon = isSuccess ? Icons.check_circle : Icons.error; // icon type

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColor.textWhite), // leading icon
            Gap.gapH16, // horizontal space
            Expanded(
              child: Text(
                message,
                style: AppTextStyle.sfProW60014.copyWith(
                  color: AppColor.textWhite,
                ), // text style
              ),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating, // floating style
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ), // rounded corners
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ), // margin
        duration: const Duration(seconds: 2), // auto dismiss time
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color color;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.height,
    this.color = AppColor.primaryButtonColor,
    this.textColor = AppColor.textWhite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 379.25,
      height: 49.54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTextStyle.sfProBold20.copyWith(color: textColor),
        ),
      ),
    );
  }
}

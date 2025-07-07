import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String label; // button text
  final VoidCallback? onPressed; // tap callback
  final double width; // button width
  final double height; // button height
  final Color color; // background color
  final Color textColor; // text color
  final bool isLoading; // new param to show loading spinner

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.height,
    this.color = AppColor.primaryButtonColor,
    this.textColor = AppColor.textWhite,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                label,
                style: AppTextStyle.sfProBold20.copyWith(color: textColor),
              ),
      ),
    );
  }
}

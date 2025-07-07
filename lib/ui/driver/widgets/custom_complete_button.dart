import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';
class CustomCompleteButton extends StatelessWidget {
  final bool isCompleted; 
  final bool isStarted;
  final VoidCallback onComplete;
  final VoidCallback onStart;

  const CustomCompleteButton({
    super.key,
    required this.isCompleted,
    required this.isStarted,
    required this.onComplete,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.boxBorder,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: isStarted ? onComplete : onStart,
        style: ElevatedButton.styleFrom(
          backgroundColor: isStarted
              ? AppColor.completedButtonColor
              : AppColor.primaryButtonColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          isStarted
              ? 'driver_screen.complete_trip'.tr()
              : 'driver_screen.start_ride'.tr(),
          style: AppTextStyle.sfProBold16.copyWith(color: AppColor.textWhite),
        ),
      ),
    );
  }
}

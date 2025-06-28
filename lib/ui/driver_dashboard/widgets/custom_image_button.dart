import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomImageButton extends StatelessWidget {
  final String imagePath;
  final String label;

  const CustomImageButton({
    Key? key,
    required this.imagePath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.appBackgroundLoginColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.boxBorder,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 24, height: 24, fit: BoxFit.contain),
          Gap.gapW16,
          Text(
            label,
            style: AppTextStyle.sfProBold16.copyWith(
              color: AppColor.primaryButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}

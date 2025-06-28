import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.sfProW60014),
        Gap.gapH8,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.borderTextColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxBorder,
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

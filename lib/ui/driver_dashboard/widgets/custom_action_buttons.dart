import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_image_button.dart';

class CustomActionButtons extends StatelessWidget {
  const CustomActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomImageButton(
            imagePath: 'assets/call.png',
            label: 'dashboard.call'.tr(),
          ),
        ),
        Gap.gapW32,
        Expanded(
          child: CustomImageButton(
            imagePath: 'assets/message.png',
            label: 'dashboard.message'.tr(),
          ),
        ),
      ],
    );
  }
}

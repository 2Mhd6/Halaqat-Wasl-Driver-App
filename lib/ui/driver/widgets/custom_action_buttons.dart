import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/methods/map_method.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_image_button.dart';


class CustomActionButtons extends StatelessWidget {
  final String phoneNumber;
  const CustomActionButtons({super.key, required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Call button
        Expanded(
          child: GestureDetector(
            onTap: () => MapMethod.makePhoneCall(phoneNumber),
            child: CustomImageButton(
              imagePath: 'assets/image/call.png',
              label: 'driver_screen.call'.tr(),
            ),
          ),
        ),
        Gap.gapW32,
        // WhatsApp message button
        Expanded(
          child: GestureDetector(
            onTap: () => MapMethod.openWhatsApp(phoneNumber),
            child: CustomImageButton(
              imagePath: 'assets/image/message.png',
              label: 'driver_screen.message'.tr(),
            ),
          ),
        ),
      ],
    );
  }
}

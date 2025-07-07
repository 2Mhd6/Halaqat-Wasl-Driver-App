import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale; 
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // center content vertically
        children: [
          // Message text
          Text(
            'driver_screen.no_ride'.tr(), // localized empty state message
            textAlign: TextAlign.center,
            style: AppTextStyle.sfProW40016,
          ),
          Gap.gapH16, // vertical spacing
          // Image icon
          Image.asset('assets/image/car.png', height: 47.09, width: 118.34),
        ],
      ),
    );
  }
}

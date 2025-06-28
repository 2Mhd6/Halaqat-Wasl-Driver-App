import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'dashboard.no_ride'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyle.sfProW40016,
          ),
          Gap.gapH16,
          Image.asset('assets/car.png', height: 47.09, width: 118.34),
        ],
      ),
    );
  }
}

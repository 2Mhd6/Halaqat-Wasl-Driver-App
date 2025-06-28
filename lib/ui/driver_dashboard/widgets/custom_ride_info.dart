import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomRideInfo extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final String date;
  final String time;

  const CustomRideInfo({
    Key? key,
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const Icon(Icons.my_location, color: AppColor.primaryButtonColor),
            SizedBox(
              height: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 2,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    color: AppColor.primaryButtonColor.withOpacity(0.5),
                  );
                }),
              ),
            ),
            const Icon(Icons.location_on_outlined, color: AppColor.primaryButtonColor),
          ],
        ),
        Gap.gapW8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pickup, style: AppTextStyle.sfPro14),
              Gap.gapH32,
              Text(dropoff, style: AppTextStyle.sfPro14),
            ],
          ),
        ),
        Container(
          height: 80,
          width: 1,
          color: AppColor.boxBorder,
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(date, style: AppTextStyle.sfProW60016),
            Gap.gapH4,
            Text(time, style: AppTextStyle.sfPro14.copyWith()),
          ],
        ),
      ],
    );
  }
}
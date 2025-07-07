import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';

class CustomRideInfo extends StatelessWidget {
  final String pickup; // pickup location text
  final String dropoff; // dropoff location text
  final String date; // ride date
  final String time; // ride time

  final VoidCallback? onPickupTap;
  final VoidCallback? onDropoffTap;

  const CustomRideInfo({
    super.key,
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.time,
    this.onPickupTap,
    this.onDropoffTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: onPickupTap,
              child: const Icon(
                Icons.my_location,
                color: AppColor.primaryButtonColor,
              ),
            ), // pickup icon
            SizedBox(
              height: 24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 2,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    color: AppColor.primaryButtonColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onDropoffTap,
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColor.primaryButtonColor,
              ),
            ), // dropoff icon
          ],
        ),
        Gap.gapW8, // spacing
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onPickupTap,
                child: Text(pickup, style: AppTextStyle.sfPro14),
              ), // pickup text
              Gap.gapH32,
              GestureDetector(
                onTap: onDropoffTap,
                child: Text(dropoff, style: AppTextStyle.sfPro14),
              ), // dropoff text
            ],
          ),
        ),
        Container(
          height: 80,
          width: 1,
          color: AppColor.boxBorder, // separator line
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(date, style: AppTextStyle.sfProW60016), // date
            Gap.gapH4,
            Text(time, style: AppTextStyle.sfPro14), // time
          ],
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_action_buttons.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_complete_button.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_ride_info.dart';

class CustomRideCard extends StatelessWidget {
  final int index;
  final String pickup;
  final String dropoff;
  final String date;
  final String time;
  final String name;
  final bool isActive;
  final bool isCompleted;
  final VoidCallback onComplete;

  const CustomRideCard({
    Key? key,
    required this.index,
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.time,
    required this.name,
    required this.isActive,
    required this.isCompleted,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColor.appBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.boxBorder,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRideInfo(
            pickup: pickup,
            dropoff: dropoff,
            date: date,
            time: time,
          ),
          if (isActive) ...[
            Gap.gapH64,
            Center(child: Text(name, style: AppTextStyle.sfProBold16)),
            Gap.gapH32,
            CustomActionButtons(),
            Gap.gapH16,
            CustomCompleteButton(isCompleted: isCompleted, onComplete: onComplete),
          ],
        ],
      ),
    );
  }
}
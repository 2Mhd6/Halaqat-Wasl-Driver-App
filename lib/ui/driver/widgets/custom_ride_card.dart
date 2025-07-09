import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/theme/app_text_style.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/bloc/driver_bloc.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/bloc/driver_event.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_action_buttons.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_complete_button.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_ride_info.dart';

class CustomRideCard extends StatelessWidget {
  final int index;
  final String pickup;
  final String dropoff;
  final String date;
  final String time;
  final String name;
  final String phoneNumber; 
  final bool isActive;
  final bool isCompleted;
  final bool isStarted;
  final VoidCallback onComplete;
  final VoidCallback onStart;
  final double? pickupLat;
  final double? pickupLong;
  final double? dropoffLat;
  final double? dropoffLong;

  final VoidCallback? onPickupTap;
  final VoidCallback? onDropoffTap;

  const CustomRideCard({
    super.key,
    required this.index,
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.time,
    required this.name,
    required this.phoneNumber, 
    required this.isActive,
    required this.isCompleted,
    required this.onComplete,
    this.pickupLat,
    this.pickupLong,
    this.dropoffLat,
    this.dropoffLong,
    this.onPickupTap,
    this.onDropoffTap,
    required this.onStart,
    required this.isStarted,
  });

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
            onPickupTap: onPickupTap,
            onDropoffTap: onDropoffTap,
          ),
          if (isActive) ...[
            Gap.gapH64,
            Center(child: Text(name, style: AppTextStyle.sfProBold16)),
            Gap.gapH32,
            CustomActionButtons(phoneNumber: phoneNumber), 
            Gap.gapH16,
            CustomCompleteButton(
              onComplete: () {
                context.read<DriverBloc>().add(CompleteRide(index));
              },
              isCompleted: isCompleted,
              isStarted: isStarted,
              onStart: () {
                context.read<DriverBloc>().add(StartRide(index));
              },
            ),
          ],
        ],
      ),
    );
  }
}

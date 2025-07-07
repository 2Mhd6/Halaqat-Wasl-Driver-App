import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/methods/date_method.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/methods/map_method.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_ride_card.dart';
import 'package:halaqat_wasl_driver_app/model/request model/request_model.dart';

class CustomRidesList extends StatelessWidget {
  final List<RequestModel> requests;
  final Function(int) onRideSelected;
  final int? selectedIndex;
  final Set<int> completedRides;
  final Function(int) onCompleteRide;

  const CustomRidesList({
    super.key,
    required this.requests,
    required this.onRideSelected,
    required this.selectedIndex,
    required this.completedRides,
    required this.onCompleteRide,
  });

  @override
  Widget build(BuildContext context) {
    final _ = context.locale; 
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      separatorBuilder: (context, index) => Gap.gapH24,
      itemBuilder: (context, index) {
        final ride = requests[index];
        final dateTime = ride.date;

        return GestureDetector(
          onTap: () => onRideSelected(index),
          child: CustomRideCard(
            phoneNumber: ride.user!.phoneNumber,
            index: index,
            pickup: ride.pickupDisplay,
            dropoff: ride.destinationDisplay,
            date: DateMethod.formatDate(dateTime),
            time: DateMethod.formatTime(dateTime),
            name: ride.user!.fullName,
            isActive: selectedIndex == index,
            isCompleted: completedRides.contains(index),
            onComplete: () => onCompleteRide(index),
            pickupLat: ride.pickupLat,
            pickupLong: ride.pickupLong,
            dropoffLat: ride.destinationLat,
            dropoffLong: ride.destinationLong,

            onPickupTap: () {
              if (ride.pickupLat != null && ride.pickupLong != null) {
                MapMethod.openMap(ride.pickupLat!, ride.pickupLong!);
              }
            },
            onDropoffTap: () {
              if (ride.destinationLat != null && ride.destinationLong != null) {
                MapMethod.openMap(ride.destinationLat!, ride.destinationLong!);
              }
            },
            onStart: () => ride.isStarted,
            isStarted: ride.isStarted,
          ),
        );
      },
    );
  }
}

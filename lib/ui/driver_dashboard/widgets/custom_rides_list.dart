import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_ride_card.dart';

class CustomRidesList extends StatelessWidget {
  final Function(int) onRideSelected;
  final int? selectedIndex;
  final Set<int> completedRides;
  final Function(int) onCompleteRide;

  const CustomRidesList({
    Key? key,
    required this.onRideSelected,
    required this.selectedIndex,
    required this.completedRides,
    required this.onCompleteRide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rides = [
      {
        'pickup': 'dashboard.pickup_hail'.tr(),
        'dropoff': 'dashboard.dropoff_hospital'.tr(),
        'date':
            '${'dashboard.day_mon'.tr()}\n25, ${'dashboard.month_may'.tr()}',
        'time': '12:00pm',
        'name': 'dashboard.name_mohammed_ali'.tr(),
      },
      {
        'pickup': 'dashboard.pickup_hail'.tr(),
        'dropoff': 'dashboard.dropoff_hospital'.tr(),
        'date':
            '${'dashboard.day_mon'.tr()}\n30, ${'dashboard.month_may'.tr()}',
        'time': '12:00pm',
        'name': 'dashboard.name_ahmed_saleh'.tr(),
      },
      {
        'pickup': 'dashboard.pickup_hail'.tr(),
        'dropoff': 'dashboard.dropoff_hospital'.tr(),
        'date': '${'dashboard.day_tue'.tr()}\n9, ${'dashboard.month_feb'.tr()}',
        'time': '10:00am',
        'name': 'dashboard.name_fatima_noor'.tr(),
      },
    ];

    if (rides.isEmpty) {
      return Center(
        child: Text(
          'dashboard.no_rides'.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }
    return ListView.separated(
      itemCount: rides.length,
      separatorBuilder: (context, index) => Gap.gapH24,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return GestureDetector(
          onTap: () => onRideSelected(index),
          child: CustomRideCard(
            index: index,
            pickup: ride['pickup']!,
            dropoff: ride['dropoff']!,
            date: ride['date']!,
            time: ride['time']!,
            name: ride['name']!,
            isActive: selectedIndex == index,
            isCompleted: completedRides.contains(index),
            onComplete: () => onCompleteRide(index),
          ),
        );
      },
    );
  }
}

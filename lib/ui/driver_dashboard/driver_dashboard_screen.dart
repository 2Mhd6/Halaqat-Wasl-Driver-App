import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/bloc/driver_dashboard_bloc.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/bloc/driver_dashboard_event.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/bloc/driver_dashboard_state.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_empty.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_header.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/widgets/custom_rides_list.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DriverDashboardBloc()..add(LoadRides()),
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BlocBuilder<DriverDashboardBloc, DriverDashboardState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomHeader(name: 'Abdulrahman'),
                    Gap.gapH20,
                    Expanded(
                      child: state.isLoading
                          ? const CustomEmpty()
                          : CustomRidesList(
                              onRideSelected: (index) {
                                context.read<DriverDashboardBloc>().add(
                                  SelectRide(index),
                                );
                              },
                              selectedIndex: state.selectedIndex,
                              completedRides: state.completedRides,
                              onCompleteRide: (index) {
                                context.read<DriverDashboardBloc>().add(
                                  CompleteRide(index),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

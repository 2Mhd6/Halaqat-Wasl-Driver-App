import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_driver_app/repo/authentication/authentication.dart';
import 'package:halaqat_wasl_driver_app/repo/request/request_service.dart';
import 'package:halaqat_wasl_driver_app/shared/widgets/gap.dart';
import 'package:halaqat_wasl_driver_app/theme/app_color.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/bloc/driver_bloc.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/bloc/driver_event.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/bloc/driver_state.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_empty.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_header.dart';
import 'package:halaqat_wasl_driver_app/ui/driver/widgets/custom_rides_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverBloc(
        authentication: Authentication(),
        requestService: RequestService(Supabase.instance.client),
      )..add(LoadRides()),
      child: Scaffold(
        backgroundColor: AppColor.appBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: BlocConsumer<DriverBloc, DriverState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: AppColor.logoutButtonColor,
                    ),
                  );
                  context.read<DriverBloc>().add(ClearError());
                }
              },
              builder: (context, state) {
                if (state.isLoading && state.requests.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeader(
                      name: state.driver?.fullName.split(' ').first ?? '',
                    ),
                    Gap.gapH24,
                    Expanded(
                      child: state.requests.isEmpty
                          ? const CustomEmpty()
                          : CustomRidesList(
                              requests: state.requests,
                              onRideSelected: (index) => context
                                  .read<DriverBloc>()
                                  .add(SelectRide(index)),
                              selectedIndex: state.selectedIndex,
                              completedRides: state.completedRides,
                              onCompleteRide: (index) => context
                                  .read<DriverBloc>()
                                  .add(CompleteRide(index)),
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

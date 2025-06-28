import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/bloc/driver_dashboard_event.dart';
import 'package:halaqat_wasl_driver_app/ui/driver_dashboard/bloc/driver_dashboard_state.dart';

class DriverDashboardBloc extends Bloc<DriverDashboardEvent, DriverDashboardState> {
  DriverDashboardBloc() : super(DriverDashboardState()) {
    on<LoadRides>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(isLoading: false));
    });

    on<SelectRide>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });

    on<CompleteRide>((event, emit) {
      final updatedRides = Set<int>.from(state.completedRides)..add(event.index);
      emit(state.copyWith(completedRides: updatedRides));
    });
  }
}
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';
import 'package:halaqat_wasl_driver_app/repo/authentication/authentication.dart';
import 'package:halaqat_wasl_driver_app/repo/request/request_service.dart';
import 'driver_event.dart';
import 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final Authentication authentication;
  final RequestService requestService;

  StreamSubscription<List<RequestModel>>? requestStream;

  DriverBloc({required this.authentication, required this.requestService})
    : super(const DriverState()) {
    on<LoadRides>(_onLoadRides);
    on<SelectRide>(_onSelectRide);
    on<StartRide>(_onStartRide);
    on<CompleteRide>(_onCompleteRide);
    on<ClearError>(_onClearError);
    on<DriverRequestsUpdated>(_onRequestsUpdated);
  }

  Future<void> _onLoadRides(LoadRides event, Emitter<DriverState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final driver = await authentication.fetchDriver();
      if (driver == null) throw Exception("Driver profile not found");

      //  Set the driver in the state first (so it’s ready before stream emits)
      emit(state.copyWith(isLoading: false, driver: driver));

      //  Cancel previous stream if any
      await requestStream?.cancel();

      //  Subscribe to live request updates
      requestStream = requestService
          .streamDriverRequests(driver.driverId)
          .listen((requests) {
            add(DriverRequestsUpdated(requests));
          });
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load rides',
        ),
      );
    }
  }

  void _onRequestsUpdated(
    DriverRequestsUpdated event,
    Emitter<DriverState> emit,
  ) {
    final completedIndices = event.requests
        .asMap()
        .entries
        .where((entry) => entry.value.isCompleted)
        .map((entry) => entry.key)
        .toSet();

    emit(
      state.copyWith(
        requests: event.requests,
        completedRides: completedIndices,
      ),
    );
  }

  Future<void> _onStartRide(StartRide event, Emitter<DriverState> emit) async {
    if (event.index >= state.requests.length) return;

    try {
      final request = state.requests[event.index];
      await requestService.markRequestStarted(request.requestId);

      final updatedRequests = List<RequestModel>.from(state.requests)
        ..[event.index] = request.copyWith(status: 'on trip');

      emit(state.copyWith(requests: updatedRequests));
    } catch (e) {
      emit(
        state.copyWith(errorMessage: 'Failed to start ride'),
      );
    }
  }

  Future<void> _onCompleteRide(
    CompleteRide event,
    Emitter<DriverState> emit,
  ) async {
    if (event.index >= state.requests.length) return;

    try {
      final request = state.requests[event.index];
      await requestService.markRequestCompleted(request.requestId);

      emit(state);
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to complete ride',
        ),
      );
    }
  }

  void _onSelectRide(SelectRide event, Emitter<DriverState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onClearError(ClearError event, Emitter<DriverState> emit) {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    requestStream?.cancel();
    return super.close();
  }
}

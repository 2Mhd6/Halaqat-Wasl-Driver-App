import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';
import 'package:halaqat_wasl_driver_app/model/driver%20model/driver_model.dart';

class DriverState {
  final bool isLoading;
  final bool isRefreshing;
  final int? selectedIndex;
  final int? startedIndex; 
  final Set<int> completedRides;
  final DriverModel? driver;
  final List<RequestModel> requests;
  final String? errorMessage;
  final String? completionError;

  const DriverState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.selectedIndex,
    this.startedIndex, 
    this.completedRides = const {},
    this.driver,
    this.requests = const [],
    this.errorMessage,
    this.completionError,
  });

  bool get hasError => errorMessage != null || completionError != null;
  bool get hasDriver => driver != null;
  bool get hasRequests => requests.isNotEmpty;

  DriverState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    int? selectedIndex,
    int? startedIndex, 
    Set<int>? completedRides,
    DriverModel? driver,
    List<RequestModel>? requests,
    String? errorMessage,
    String? completionError,
  }) {
    return DriverState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      startedIndex: startedIndex ?? this.startedIndex, 
      completedRides: completedRides ?? this.completedRides,
      driver: driver ?? this.driver,
      requests: requests ?? this.requests,
      errorMessage: errorMessage,
      completionError: completionError,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverState &&
        other.isLoading == isLoading &&
        other.isRefreshing == isRefreshing &&
        other.selectedIndex == selectedIndex &&
        other.startedIndex == startedIndex &&
        other.completedRides == completedRides &&
        other.driver == driver &&
        other.requests == requests &&
        other.errorMessage == errorMessage &&
        other.completionError == completionError;
  }

  @override
  int get hashCode {
    return Object.hash(
      isLoading,
      isRefreshing,
      selectedIndex,
      startedIndex, 
      completedRides,
      driver,
      requests,
      errorMessage,
      completionError,
    );
  }
}

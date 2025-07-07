import 'package:halaqat_wasl_driver_app/model/request%20model/request_model.dart';

abstract class DriverEvent {
  const DriverEvent();
}

/// Fetches the driver profile and their associated rides
class LoadRides extends DriverEvent {
  final bool forceRefresh;
  const LoadRides({this.forceRefresh = false});
}

/// Marks a specific ride as selected in the UI
class SelectRide extends DriverEvent {
  final int index;
  const SelectRide(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectRide &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}

/// Triggers a ride to be marked as "started" in UI
class StartRide extends DriverEvent {
  final int index;
  const StartRide(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StartRide &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}

/// Marks a ride as completed in the system
class CompleteRide extends DriverEvent {
  final int index;
  const CompleteRide(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompleteRide &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}
class DriverRequestsUpdated extends DriverEvent {
  final List<RequestModel> requests;

  const DriverRequestsUpdated(this.requests);
}

/// Clears any current error message in the state
class ClearError extends DriverEvent {
  const ClearError();
}

/// Refreshes the status of completed rides (optional usage)
class RefreshCompletedRides extends DriverEvent {
  const RefreshCompletedRides();
}

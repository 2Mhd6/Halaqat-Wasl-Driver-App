abstract class DriverDashboardEvent {
  const DriverDashboardEvent();
}

class LoadRides extends DriverDashboardEvent {}

class SelectRide extends DriverDashboardEvent {
  final int index;

  SelectRide(this.index);
}

class CompleteRide extends DriverDashboardEvent {
  final int index;

  CompleteRide(this.index);
}
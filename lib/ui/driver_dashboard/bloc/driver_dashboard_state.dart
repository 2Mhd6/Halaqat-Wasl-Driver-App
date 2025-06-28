class DriverDashboardState {
  final bool isLoading;
  final int? selectedIndex;
  final Set<int> completedRides;

  DriverDashboardState({
    this.isLoading = true,
    this.selectedIndex,
    Set<int>? completedRides,
  }) : completedRides = completedRides ?? {};

  DriverDashboardState copyWith({
    bool? isLoading,
    int? selectedIndex,
    Set<int>? completedRides,
  }) {
    return DriverDashboardState(
      isLoading: isLoading ?? this.isLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      completedRides: completedRides ?? this.completedRides,
    );
  }
}
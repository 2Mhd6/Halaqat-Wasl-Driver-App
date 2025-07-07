// ignore_for_file: public_member_api_docs, sort_constructors_first
// This file is "model.dart"
import 'package:dart_mappable/dart_mappable.dart';
part 'driver_model.mapper.dart';

@MappableClass()
class DriverModel with DriverModelMappable {
  DriverModel({
    required this.driverId,
    required this.charityId,
    required this.notificationId,
    required this.fullName,
    required this.role,
    required this.status,
    required this.totalServices,
  });

  @MappableField(key: 'driver_id')
  final String driverId;

  @MappableField(key: 'charity_id')
  final String charityId;

  @MappableField(key: 'notification_id')
  final String? notificationId;

  @MappableField(key: 'full_name')
  final String fullName;

  final String role;

  final String status;

  @MappableField(key: 'total_services')
  final int totalServices;
}

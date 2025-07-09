import 'dart:convert';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:halaqat_wasl_driver_app/model/hospital%20model/hospital_model.dart';
import 'package:halaqat_wasl_driver_app/model/user%20model/user_model.dart';
part 'request_model.mapper.dart';

@MappableClass()
class RequestModel with RequestModelMappable {
  final String requestId;
  final String? userId;
  final UserModel? user;
  final String? charityId;
  final String? driverId;
  final String? hospitalId;
  final HospitalModel? hospital;
  final String? complaintId;
  final double? pickupLat;
  final double? pickupLong;
  final double? destinationLat;
  final double? destinationLong;
  final String? status;
  final String? note;
  final DateTime? date;
  final String? pickupName;
  final String? destinationName;

  const RequestModel({
    required this.requestId,
    this.userId,
    this.user,
    this.charityId,
    this.driverId,
    this.hospitalId,
    this.hospital,
    this.complaintId,
    this.pickupLat,
    this.pickupLong,
    this.destinationLat,
    this.destinationLong,
    this.status,
    this.note,
    this.date,
    this.pickupName,
    this.destinationName,
  });

  // Mapper initialization
  static final fromJson = RequestModelMapper.fromJson;
  static final fromMap = RequestModelMapper.fromMap;

  // Enhanced factory method for Supabase responses
  factory RequestModel.fromSupabase(Map<String, dynamic> json) {
    try {
      return RequestModel(
        requestId: _parseString(json['request_id'], 'request_id'),
        userId: json['user_id'] as String?,
        user: _parseUser(json['user']),
        charityId: json['charity_id'] as String?,
        driverId: json['driver_id'] as String?,
        hospitalId: json['hospital_id'] as String?,
        hospital: _parseHospital(json['hospital']),
        complaintId: json['complaint_id'] as String?,
        pickupLat: _parseDouble(json['pick_up_lat']),
        pickupLong: _parseDouble(json['pick_up_long']),
        destinationLat: _parseDouble(json['destination_lat']),
        destinationLong: _parseDouble(json['destination_long']),
        status: json['status'] as String?,
        note: json['note'] as String?,
        date: _parseDateTime(json['request_date']),
        pickupName: json['pickup_name'] as String?,
        destinationName: json['destination_name'] as String?,
      );
    } catch (e, stack) {
      throw FormatException(
        'Failed to parse RequestModel: $e\n'
        'JSON: ${jsonEncode(json)}\n'
        'Stack trace: $stack',
      );
    }
  }

  // Helper methods for parsing
  static String _parseString(dynamic value, String fieldName) {
    if (value == null) throw FormatException('$fieldName is required');
    return value.toString();
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  static UserModel? _parseUser(dynamic userData) {
    if (userData == null) return null;
    try {
      return userData is Map<String, dynamic>
          ? UserModelMapper.fromMap(userData)
          : UserModelMapper.fromJson(userData.toString());
    } catch (e) {
      print('Warning: Failed to parse user - $e');
      return null;
    }
  }

  static HospitalModel? _parseHospital(dynamic hospitalData) {
    if (hospitalData == null) return null;
    try {
      return hospitalData is Map<String, dynamic>
          ? HospitalModelMapper.fromMap(hospitalData)
          : HospitalModelMapper.fromJson(hospitalData.toString());
    } catch (e) {
      return null;
    }
  }

  // Convert to Supabase-compatible map
  Map<String, dynamic> toSupabaseMap() {
    return {
      'request_id': requestId,
      'user_id': userId,
      'charity_id': charityId,
      'driver_id': driverId,
      'hospital_id': hospitalId,
      'complaint_id': complaintId,
      'pick_up_lat': pickupLat,
      'pick_up_long': pickupLong,
      'destination_lat': destinationLat,
      'destination_long': destinationLong,
      'status': status,
      'note': note,
      'request_date': date?.toIso8601String(),
      'pickup_name': pickupName,
      'destination_name': destinationName,
    }..removeWhere((_, value) => value == null);
  }

  // Location helpers
  bool get hasPickupLocation => pickupLat != null && pickupLong != null;
  bool get hasDestinationLocation =>
      destinationLat != null && destinationLong != null;
  bool get isCompleted => status?.toLowerCase() == 'completed';
  bool get isStarted => status == 'on trip';
  // Display methods
  String get pickupDisplay =>
      pickupName ?? _formatCoordinates(pickupLat, pickupLong);
  String get destinationDisplay =>
      destinationName ?? _formatCoordinates(destinationLat, destinationLong);

  static String _formatCoordinates(double? lat, double? lng) {
    return (lat == null || lng == null)
        ? 'Location not set'
        : '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';
  }

  @override
  String toString() {
    return 'RequestModel('
        'requestId: $requestId, '
        'status: $status, '
        'user: $user, '
        'hospital: $hospital';
  }
}

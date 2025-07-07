import 'package:dart_mappable/dart_mappable.dart';
part 'user_model.mapper.dart';

@MappableClass()
class UserModel with UserModelMappable {
  UserModel({
    required this.userId,
    required this.notificationId,
    required this.role,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  @MappableField(key: 'user_id')
  final String userId;
  @MappableField(key: 'notification_id')
  final String? notificationId;

  @MappableField(key: 'full_name')
  final String fullName;

  final String role;

  final String email;

  @MappableField(key: 'phone_number')
  final String phoneNumber;

  final String gender;
}

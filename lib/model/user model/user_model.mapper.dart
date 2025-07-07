// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_model.dart';

class UserModelMapper extends ClassMapperBase<UserModel> {
  UserModelMapper._();

  static UserModelMapper? _instance;
  static UserModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserModel';

  static String _$userId(UserModel v) => v.userId;
  static const Field<UserModel, String> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static String? _$notificationId(UserModel v) => v.notificationId;
  static const Field<UserModel, String> _f$notificationId =
      Field('notificationId', _$notificationId, key: r'notification_id');
  static String _$role(UserModel v) => v.role;
  static const Field<UserModel, String> _f$role = Field('role', _$role);
  static String _$fullName(UserModel v) => v.fullName;
  static const Field<UserModel, String> _f$fullName =
      Field('fullName', _$fullName, key: r'full_name');
  static String _$email(UserModel v) => v.email;
  static const Field<UserModel, String> _f$email = Field('email', _$email);
  static String _$phoneNumber(UserModel v) => v.phoneNumber;
  static const Field<UserModel, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber, key: r'phone_number');
  static String _$gender(UserModel v) => v.gender;
  static const Field<UserModel, String> _f$gender = Field('gender', _$gender);

  @override
  final MappableFields<UserModel> fields = const {
    #userId: _f$userId,
    #notificationId: _f$notificationId,
    #role: _f$role,
    #fullName: _f$fullName,
    #email: _f$email,
    #phoneNumber: _f$phoneNumber,
    #gender: _f$gender,
  };

  static UserModel _instantiate(DecodingData data) {
    return UserModel(
        userId: data.dec(_f$userId),
        notificationId: data.dec(_f$notificationId),
        role: data.dec(_f$role),
        fullName: data.dec(_f$fullName),
        email: data.dec(_f$email),
        phoneNumber: data.dec(_f$phoneNumber),
        gender: data.dec(_f$gender));
  }

  @override
  final Function instantiate = _instantiate;

  static UserModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserModel>(map);
  }

  static UserModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserModel>(json);
  }
}

mixin UserModelMappable {
  String toJson() {
    return UserModelMapper.ensureInitialized()
        .encodeJson<UserModel>(this as UserModel);
  }

  Map<String, dynamic> toMap() {
    return UserModelMapper.ensureInitialized()
        .encodeMap<UserModel>(this as UserModel);
  }

  UserModelCopyWith<UserModel, UserModel, UserModel> get copyWith =>
      _UserModelCopyWithImpl<UserModel, UserModel>(
          this as UserModel, $identity, $identity);
  @override
  String toString() {
    return UserModelMapper.ensureInitialized()
        .stringifyValue(this as UserModel);
  }

  @override
  bool operator ==(Object other) {
    return UserModelMapper.ensureInitialized()
        .equalsValue(this as UserModel, other);
  }

  @override
  int get hashCode {
    return UserModelMapper.ensureInitialized().hashValue(this as UserModel);
  }
}

extension UserModelValueCopy<$R, $Out> on ObjectCopyWith<$R, UserModel, $Out> {
  UserModelCopyWith<$R, UserModel, $Out> get $asUserModel =>
      $base.as((v, t, t2) => _UserModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserModelCopyWith<$R, $In extends UserModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? userId,
      String? notificationId,
      String? role,
      String? fullName,
      String? email,
      String? phoneNumber,
      String? gender});
  UserModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserModel, $Out>
    implements UserModelCopyWith<$R, UserModel, $Out> {
  _UserModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserModel> $mapper =
      UserModelMapper.ensureInitialized();
  @override
  $R call(
          {String? userId,
          Object? notificationId = $none,
          String? role,
          String? fullName,
          String? email,
          String? phoneNumber,
          String? gender}) =>
      $apply(FieldCopyWithData({
        if (userId != null) #userId: userId,
        if (notificationId != $none) #notificationId: notificationId,
        if (role != null) #role: role,
        if (fullName != null) #fullName: fullName,
        if (email != null) #email: email,
        if (phoneNumber != null) #phoneNumber: phoneNumber,
        if (gender != null) #gender: gender
      }));
  @override
  UserModel $make(CopyWithData data) => UserModel(
      userId: data.get(#userId, or: $value.userId),
      notificationId: data.get(#notificationId, or: $value.notificationId),
      role: data.get(#role, or: $value.role),
      fullName: data.get(#fullName, or: $value.fullName),
      email: data.get(#email, or: $value.email),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      gender: data.get(#gender, or: $value.gender));

  @override
  UserModelCopyWith<$R2, UserModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

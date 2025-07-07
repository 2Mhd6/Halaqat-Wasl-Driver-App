// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'request_model.dart';

class RequestModelMapper extends ClassMapperBase<RequestModel> {
  RequestModelMapper._();

  static RequestModelMapper? _instance;
  static RequestModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RequestModelMapper._());
      UserModelMapper.ensureInitialized();
      HospitalModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RequestModel';

  static String _$requestId(RequestModel v) => v.requestId;
  static const Field<RequestModel, String> _f$requestId =
      Field('requestId', _$requestId);
  static String? _$userId(RequestModel v) => v.userId;
  static const Field<RequestModel, String> _f$userId =
      Field('userId', _$userId, opt: true);
  static UserModel? _$user(RequestModel v) => v.user;
  static const Field<RequestModel, UserModel> _f$user =
      Field('user', _$user, opt: true);
  static String? _$charityId(RequestModel v) => v.charityId;
  static const Field<RequestModel, String> _f$charityId =
      Field('charityId', _$charityId, opt: true);
  static String? _$driverId(RequestModel v) => v.driverId;
  static const Field<RequestModel, String> _f$driverId =
      Field('driverId', _$driverId, opt: true);
  static String? _$hospitalId(RequestModel v) => v.hospitalId;
  static const Field<RequestModel, String> _f$hospitalId =
      Field('hospitalId', _$hospitalId, opt: true);
  static HospitalModel? _$hospital(RequestModel v) => v.hospital;
  static const Field<RequestModel, HospitalModel> _f$hospital =
      Field('hospital', _$hospital, opt: true);
  static String? _$complaintId(RequestModel v) => v.complaintId;
  static const Field<RequestModel, String> _f$complaintId =
      Field('complaintId', _$complaintId, opt: true);
  static double? _$pickupLat(RequestModel v) => v.pickupLat;
  static const Field<RequestModel, double> _f$pickupLat =
      Field('pickupLat', _$pickupLat, opt: true);
  static double? _$pickupLong(RequestModel v) => v.pickupLong;
  static const Field<RequestModel, double> _f$pickupLong =
      Field('pickupLong', _$pickupLong, opt: true);
  static double? _$destinationLat(RequestModel v) => v.destinationLat;
  static const Field<RequestModel, double> _f$destinationLat =
      Field('destinationLat', _$destinationLat, opt: true);
  static double? _$destinationLong(RequestModel v) => v.destinationLong;
  static const Field<RequestModel, double> _f$destinationLong =
      Field('destinationLong', _$destinationLong, opt: true);
  static String? _$status(RequestModel v) => v.status;
  static const Field<RequestModel, String> _f$status =
      Field('status', _$status, opt: true);
  static String? _$note(RequestModel v) => v.note;
  static const Field<RequestModel, String> _f$note =
      Field('note', _$note, opt: true);
  static DateTime? _$date(RequestModel v) => v.date;
  static const Field<RequestModel, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static String? _$pickupName(RequestModel v) => v.pickupName;
  static const Field<RequestModel, String> _f$pickupName =
      Field('pickupName', _$pickupName, opt: true);
  static String? _$destinationName(RequestModel v) => v.destinationName;
  static const Field<RequestModel, String> _f$destinationName =
      Field('destinationName', _$destinationName, opt: true);

  @override
  final MappableFields<RequestModel> fields = const {
    #requestId: _f$requestId,
    #userId: _f$userId,
    #user: _f$user,
    #charityId: _f$charityId,
    #driverId: _f$driverId,
    #hospitalId: _f$hospitalId,
    #hospital: _f$hospital,
    #complaintId: _f$complaintId,
    #pickupLat: _f$pickupLat,
    #pickupLong: _f$pickupLong,
    #destinationLat: _f$destinationLat,
    #destinationLong: _f$destinationLong,
    #status: _f$status,
    #note: _f$note,
    #date: _f$date,
    #pickupName: _f$pickupName,
    #destinationName: _f$destinationName,
  };

  static RequestModel _instantiate(DecodingData data) {
    return RequestModel(
        requestId: data.dec(_f$requestId),
        userId: data.dec(_f$userId),
        user: data.dec(_f$user),
        charityId: data.dec(_f$charityId),
        driverId: data.dec(_f$driverId),
        hospitalId: data.dec(_f$hospitalId),
        hospital: data.dec(_f$hospital),
        complaintId: data.dec(_f$complaintId),
        pickupLat: data.dec(_f$pickupLat),
        pickupLong: data.dec(_f$pickupLong),
        destinationLat: data.dec(_f$destinationLat),
        destinationLong: data.dec(_f$destinationLong),
        status: data.dec(_f$status),
        note: data.dec(_f$note),
        date: data.dec(_f$date),
        pickupName: data.dec(_f$pickupName),
        destinationName: data.dec(_f$destinationName));
  }

  @override
  final Function instantiate = _instantiate;

  static RequestModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RequestModel>(map);
  }

  static RequestModel fromJson(String json) {
    return ensureInitialized().decodeJson<RequestModel>(json);
  }
}

mixin RequestModelMappable {
  String toJson() {
    return RequestModelMapper.ensureInitialized()
        .encodeJson<RequestModel>(this as RequestModel);
  }

  Map<String, dynamic> toMap() {
    return RequestModelMapper.ensureInitialized()
        .encodeMap<RequestModel>(this as RequestModel);
  }

  RequestModelCopyWith<RequestModel, RequestModel, RequestModel> get copyWith =>
      _RequestModelCopyWithImpl<RequestModel, RequestModel>(
          this as RequestModel, $identity, $identity);
  @override
  String toString() {
    return RequestModelMapper.ensureInitialized()
        .stringifyValue(this as RequestModel);
  }

  @override
  bool operator ==(Object other) {
    return RequestModelMapper.ensureInitialized()
        .equalsValue(this as RequestModel, other);
  }

  @override
  int get hashCode {
    return RequestModelMapper.ensureInitialized()
        .hashValue(this as RequestModel);
  }
}

extension RequestModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RequestModel, $Out> {
  RequestModelCopyWith<$R, RequestModel, $Out> get $asRequestModel =>
      $base.as((v, t, t2) => _RequestModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class RequestModelCopyWith<$R, $In extends RequestModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  UserModelCopyWith<$R, UserModel, UserModel>? get user;
  HospitalModelCopyWith<$R, HospitalModel, HospitalModel>? get hospital;
  $R call(
      {String? requestId,
      String? userId,
      UserModel? user,
      String? charityId,
      String? driverId,
      String? hospitalId,
      HospitalModel? hospital,
      String? complaintId,
      double? pickupLat,
      double? pickupLong,
      double? destinationLat,
      double? destinationLong,
      String? status,
      String? note,
      DateTime? date,
      String? pickupName,
      String? destinationName});
  RequestModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RequestModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RequestModel, $Out>
    implements RequestModelCopyWith<$R, RequestModel, $Out> {
  _RequestModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RequestModel> $mapper =
      RequestModelMapper.ensureInitialized();
  @override
  UserModelCopyWith<$R, UserModel, UserModel>? get user =>
      $value.user?.copyWith.$chain((v) => call(user: v));
  @override
  HospitalModelCopyWith<$R, HospitalModel, HospitalModel>? get hospital =>
      $value.hospital?.copyWith.$chain((v) => call(hospital: v));
  @override
  $R call(
          {String? requestId,
          Object? userId = $none,
          Object? user = $none,
          Object? charityId = $none,
          Object? driverId = $none,
          Object? hospitalId = $none,
          Object? hospital = $none,
          Object? complaintId = $none,
          Object? pickupLat = $none,
          Object? pickupLong = $none,
          Object? destinationLat = $none,
          Object? destinationLong = $none,
          Object? status = $none,
          Object? note = $none,
          Object? date = $none,
          Object? pickupName = $none,
          Object? destinationName = $none}) =>
      $apply(FieldCopyWithData({
        if (requestId != null) #requestId: requestId,
        if (userId != $none) #userId: userId,
        if (user != $none) #user: user,
        if (charityId != $none) #charityId: charityId,
        if (driverId != $none) #driverId: driverId,
        if (hospitalId != $none) #hospitalId: hospitalId,
        if (hospital != $none) #hospital: hospital,
        if (complaintId != $none) #complaintId: complaintId,
        if (pickupLat != $none) #pickupLat: pickupLat,
        if (pickupLong != $none) #pickupLong: pickupLong,
        if (destinationLat != $none) #destinationLat: destinationLat,
        if (destinationLong != $none) #destinationLong: destinationLong,
        if (status != $none) #status: status,
        if (note != $none) #note: note,
        if (date != $none) #date: date,
        if (pickupName != $none) #pickupName: pickupName,
        if (destinationName != $none) #destinationName: destinationName
      }));
  @override
  RequestModel $make(CopyWithData data) => RequestModel(
      requestId: data.get(#requestId, or: $value.requestId),
      userId: data.get(#userId, or: $value.userId),
      user: data.get(#user, or: $value.user),
      charityId: data.get(#charityId, or: $value.charityId),
      driverId: data.get(#driverId, or: $value.driverId),
      hospitalId: data.get(#hospitalId, or: $value.hospitalId),
      hospital: data.get(#hospital, or: $value.hospital),
      complaintId: data.get(#complaintId, or: $value.complaintId),
      pickupLat: data.get(#pickupLat, or: $value.pickupLat),
      pickupLong: data.get(#pickupLong, or: $value.pickupLong),
      destinationLat: data.get(#destinationLat, or: $value.destinationLat),
      destinationLong: data.get(#destinationLong, or: $value.destinationLong),
      status: data.get(#status, or: $value.status),
      note: data.get(#note, or: $value.note),
      date: data.get(#date, or: $value.date),
      pickupName: data.get(#pickupName, or: $value.pickupName),
      destinationName: data.get(#destinationName, or: $value.destinationName));

  @override
  RequestModelCopyWith<$R2, RequestModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RequestModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

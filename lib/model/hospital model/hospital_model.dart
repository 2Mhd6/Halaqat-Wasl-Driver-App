import 'package:dart_mappable/dart_mappable.dart';

part 'hospital_model.mapper.dart';

@MappableClass()
class HospitalModel with HospitalModelMappable {
  HospitalModel({
    required this.hospitalId,
    required this.name,
    required this.hospitalLat,
    required this.hospitalLong,
  });

  @MappableField(key: 'hospital_id')
  final String hospitalId;

  final String name;

  @MappableField(key: 'hospital_lat')
  final double hospitalLat;

  @MappableField(key: 'hospital_long')
  final double hospitalLong;
}

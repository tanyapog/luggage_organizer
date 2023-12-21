import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_type.freezed.dart';

@freezed
class TripType with _$TripType {
  const TripType._();

  const factory TripType({
    required String id,
    required String name,
  }) = _TripType;

  factory TripType.empty() => const TripType(
    id: "",
    name: "",
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/trip_aspect/trip_aspect.dart';

part 'trip_aspect_dto.freezed.dart';
part 'trip_aspect_dto.g.dart';

@freezed
class TripAspectDto with _$TripAspectDto {
  const TripAspectDto._();

  const factory TripAspectDto({
    @JsonKey(includeIfNull: true) String? id,
    required String name,
  }) = _TripAspectDto;

  factory TripAspectDto.fromDomain(TripAspect tripAspect) => TripAspectDto(
    id: tripAspect.id,
    name: tripAspect.name,
  );

  TripAspect toDomain() => TripAspect(
    id: id!,
    name: name,
  );

  factory TripAspectDto.fromJson(Map<String, dynamic> json) =>
      _$TripAspectDtoFromJson(json);

  factory TripAspectDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      TripAspectDto.fromJson(doc.data()!).copyWith(id: doc.id);

}

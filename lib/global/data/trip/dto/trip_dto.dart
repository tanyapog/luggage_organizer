import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/trip/trip.dart';

part 'trip_dto.freezed.dart';
part 'trip_dto.g.dart';

@freezed
class TripDto with _$TripDto {
  const TripDto._();

  const factory TripDto({
    @JsonKey(includeIfNull: true) String? id,
    required String name,
    required String description,
    required bool complete,
    required DateTime dateCreated,
  }) = _TripDto;

  factory TripDto.fromDomain(Trip trip) => TripDto(
    id: trip.id,
    name: trip.name,
    description: trip.description,
    complete: trip.complete,
    dateCreated: trip.dateCreated,
  );

  Trip toDomain() => Trip(
    id: id!, // I believe id is never null
    name: name,
    description: description,
    complete: complete,
    dateCreated: dateCreated,
  );

  factory TripDto.fromJson(Map<String, dynamic> json) =>
      _$TripDtoFromJson(json);

  factory TripDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      TripDto.fromJson(doc.data()!).copyWith(id: doc.id);
}

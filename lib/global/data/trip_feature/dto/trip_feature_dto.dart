import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/trip_feature/trip_feature.dart';
import '../../item/dto/item_dto.dart';

part 'trip_feature_dto.freezed.dart';
part 'trip_feature_dto.g.dart';

@freezed
class TripFeatureDto with _$TripFeatureDto {
  const TripFeatureDto._();

  const factory TripFeatureDto({
    @JsonKey(includeIfNull: true) String? id,
    required String name,
    @JsonKey(includeIfNull: false) String? tag,
    required List<ItemDto> items,
  }) = _TripFeatureDto;

  factory TripFeatureDto.fromDomain(TripFeature tripFeature) => TripFeatureDto(
    id: tripFeature.id,
    name: tripFeature.name,
    tag: tripFeature.tag,
    items: tripFeature.items.map((item) => ItemDto.fromDomain(item)).toList(),
  );

  TripFeature toDomain() => TripFeature(
    id: id!,
    name: name,
    tag: tag,
    items: items.map((itemDto) => itemDto.toDomain()).toList(),
  );

  factory TripFeatureDto.fromJson(Map<String, dynamic> json) =>
      _$TripFeatureDtoFromJson(json);

  factory TripFeatureDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      TripFeatureDto.fromJson(doc.data()!).copyWith(id: doc.id);
}

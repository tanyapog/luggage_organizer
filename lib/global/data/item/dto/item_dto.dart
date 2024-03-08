import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/item/item.dart';

part 'item_dto.freezed.dart';
part 'item_dto.g.dart';

@freezed
class ItemDto with _$ItemDto {
  const ItemDto._();

  const factory ItemDto({
    // initialId is a temporal id from items.json.
    // It is needed to associate items with specific trip feature
    @JsonKey(includeFromJson: true, includeToJson: false) String? initialId,
    // auto generated id from firestore
    @JsonKey(includeIfNull: false)String? id,
    required String name,
  }) = _ItemDto;

  factory ItemDto.fromDomain(Item item) => ItemDto(
    id: item.id,
    name: item.name,
  );

  Item toDomain() => Item(
    id: id!,
    name: name,
  );

  factory ItemDto.fromJson(Map<String, dynamic> json) =>
      _$ItemDtoFromJson(json);

  factory ItemDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      ItemDto.fromJson(doc.data()!).copyWith(id: doc.id);
}

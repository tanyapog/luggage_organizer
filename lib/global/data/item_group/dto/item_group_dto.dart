import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/item_group/item_group.dart';

part 'item_group_dto.freezed.dart';
part 'item_group_dto.g.dart';

@freezed
class ItemGroupDto with _$ItemGroupDto {
  const ItemGroupDto._();

  const factory ItemGroupDto({
    @JsonKey(includeIfNull: true) String? id,
    required String name,
  }) = _ItemGroupDto;

  factory ItemGroupDto.fromDomain(ItemGroup itemGroup) => ItemGroupDto(
    id: itemGroup.id,
    name: itemGroup.name,
  );

  ItemGroup toDomain() => ItemGroup(
    id: id!,
    name: name,
  );

  factory ItemGroupDto.fromJson(Map<String, dynamic> json) =>
      _$ItemGroupDtoFromJson(json);

  factory ItemGroupDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) =>
      ItemGroupDto.fromJson(doc.data()!).copyWith(id: doc.id);
}

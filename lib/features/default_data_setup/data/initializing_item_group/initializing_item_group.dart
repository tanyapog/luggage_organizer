import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../global/data/item/dto/item_dto.dart';

part 'initializing_item_group.freezed.dart';
part 'initializing_item_group.g.dart';

/// Reflects both an item group and its nested items from items.json
/// to a single dart object, that could be used to handily upload them into firestore in one go.
@freezed
class InitializingItemGroup with _$InitializingItemGroup {
  const InitializingItemGroup._();

  const factory InitializingItemGroup({
    required String name,
    @JsonKey(includeToJson: false) required List<ItemDto> items,
  }) = _InitialItemGroup;

  factory InitializingItemGroup.fromJson(Map<String, dynamic> json) =>
      _$InitializingItemGroupFromJson(json);
}
import 'package:freezed_annotation/freezed_annotation.dart';

import '../item_group/item_group.dart';

part 'item.freezed.dart';

/// A model for a physical object, that user is going to pack and take to a trip,
/// like, for example, a passport or T-short
@freezed
class Item with _$Item {
  const Item._();

  const factory Item({
    required String id,
    required String name,
    ItemGroup? group,
  }) = _Item;

  factory Item.empty() => const Item(id: "", name: "");
}
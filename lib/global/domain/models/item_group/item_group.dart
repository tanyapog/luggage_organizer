import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_group.freezed.dart';

/// It could be, for example, documents, devices or clothes
@freezed
class ItemGroup with _$ItemGroup {
  const ItemGroup._();

  const factory ItemGroup({
    required String id,
    required String name,
  }) = _ItemGroup;

  factory ItemGroup.empty() => const ItemGroup(id: "", name: "");
}
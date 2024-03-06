import 'package:freezed_annotation/freezed_annotation.dart';

import '../item/item.dart';
import '../trip_aspect/trip_aspect.dart';

part 'trip_feature.freezed.dart';

/// [TripFeature] describes what items are needed for specific aspect of a trip
/// with it [items] field
/// It could be "Business trip" or "Camping" from "Purpose" aspect,
/// or "Airplane" or "Train" from "Transport" aspect.
/// For example, the "Camping" feature would have "tent" item in [items]
@freezed
class TripFeature with _$TripFeature {
  const TripFeature._();

  const factory TripFeature({
    required String id,
    required String name,
    String? tag,
    TripAspect? tripAspect,
    required List<Item> items,
  }) = _TripFeature;

  factory TripFeature.empty() => const TripFeature(id: "", name: "", items: []);
}

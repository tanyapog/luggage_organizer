import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_aspect.freezed.dart';

/// [TripAspect] bands several TripFeatures in a group.
/// Examples:
///  - Purpose (for such features as business trip, sport event or visiting a country)
///  - Season (winter, spring, summer, autumn)
@freezed
class TripAspect with _$TripAspect {
  const TripAspect._();

  const factory TripAspect({
    required String id,
    required String name,
  }) = _TripAspect;

  factory TripAspect.empty() => const TripAspect(id: "", name: "");
}
import 'package:freezed_annotation/freezed_annotation.dart';

import '../initializing_trip_feature/initializing_trip_feature.dart';

part 'initializing_trip_aspect.freezed.dart';
part 'initializing_trip_aspect.g.dart';

/// Reflects both a tripAspect and its nested tripFeatures from items.json
/// to a single dart object, that could be used to handily upload them into firestore in one go.
@freezed
class InitializingTripAspect with _$InitializingTripAspect {

  const factory InitializingTripAspect({
    required String name,
    @JsonKey(includeToJson: false) required List<InitializingTripFeature> tripFeatures,
  }) = _InitialTripAspect;

  factory InitializingTripAspect.fromJson(Map<String, dynamic> json) =>
      _$InitializingTripAspectFromJson(json);
}
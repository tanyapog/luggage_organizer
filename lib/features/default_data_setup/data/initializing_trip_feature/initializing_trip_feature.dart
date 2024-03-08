import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'initializing_trip_feature.freezed.dart';
part 'initializing_trip_feature.g.dart';

// Reflects tripFeature from trip_features.json
@freezed
class InitializingTripFeature with _$InitializingTripFeature {

  const factory InitializingTripFeature({
    required String name,
    @JsonKey(includeIfNull: false)String? tag,
    // list of String [initialId]s from trip_features.json
    @JsonKey(includeToJson: false) @Default([]) List<String> items,
    // list of [DocumentReference]s of items already uploaded into firestore from items.json
    @JsonKey(includeFromJson: false) @Default([]) List<DocumentReference> itemDocs,
  }) = _InitializingTripFeature;

  factory InitializingTripFeature.fromJson(Map<String, dynamic> json) =>
      _$InitializingTripFeatureFromJson(json);
}
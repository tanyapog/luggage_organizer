import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../global/data/firestore_helpers.dart';
import '../../../global/domain/errors/errors.dart';
import '../../../utils/logging/logging.dart';
import 'initializing_item_group/initializing_item_group.dart';
import 'initializing_trip_aspect/initializing_trip_aspect.dart';

@LazySingleton()
class DefaultDataService {
  late FirebaseFirestore _firestore;
  Map<String, DocumentReference> itemDocInitialIds = {};

  static const _itemsAsset = 'assets/data/items.json';
  static const _tripFeaturesAsset = 'assets/data/trip_features.json';

  // singleton
  static final DefaultDataService _instance = DefaultDataService._();
  DefaultDataService._();

  factory DefaultDataService(FirebaseFirestore firestore) {
    _instance._firestore = firestore;
    return _instance;
  }

  void uploadDataForCurrentUser() async {
    final itemGroups = await _parseItemGroups();
    await _uploadItemsToFirestore(itemGroups);
    final tripAspects = await _parseTripAspects();
    await _uploadTripAspectsToFirestore(tripAspects);
  }

  Future<List<InitializingItemGroup>> _parseItemGroups() async {
    try {
      final String jsonItemGroups = await rootBundle.loadString(_itemsAsset); // todo DefaultAssetBundle.of(context) for localization
      return (jsonDecode(jsonItemGroups) as List)
          .map((jsonItemGroup) => InitializingItemGroup.fromJson(jsonItemGroup))
          .toList();
    } on Exception catch (e) {
      logError("Failed to parse $_itemsAsset: $e");
      rethrow;
    }
  }

  Future<void> _uploadItemsToFirestore(List<InitializingItemGroup> itemGroups) async {
    final userDoc = await _firestore.userDocument;
    for(var itemGroup in itemGroups) {
      await userDoc.itemGroupCollection
        .add(itemGroup.toJson())
        .then((itemGroupDoc) {
          for (var item in itemGroup.items) {
            itemGroupDoc.itemCollection
              .add(item.toJson())
              // here we remember a connection between item.initialId and newly created item's DocumentReference
              .then((itemDoc) => itemDocInitialIds[item.initialId!] = itemDoc);
          }
        });
    }
  }

  Future<List<InitializingTripAspect>> _parseTripAspects() async {
    try {
      final String jsonTripAspects = await rootBundle.loadString(_tripFeaturesAsset); // todo DefaultAssetBundle.of(context) for localization
      return (jsonDecode(jsonTripAspects) as List)
          .map((jsonTripAspect) => InitializingTripAspect.fromJson(jsonTripAspect))
          .toList();
    } on Exception catch (e) {
      logError("Failed to parse $_tripFeaturesAsset: $e");
      rethrow;
    }
  }

  Future<void> _uploadTripAspectsToFirestore(List<InitializingTripAspect> iniTripAspects) async {
    final userDoc = await _firestore.userDocument;
    for(var iniTripAspect in iniTripAspects) {
      await userDoc.tripAspectCollection
          .add(iniTripAspect.toJson())
          .then((tripAspectDoc) {
            for (var iniTripFeature in iniTripAspect.tripFeatures) {
              // now we need to make a list of DocumentReferences<Item>
              // corresponding to the list of item's initialId, from trip_features.json
              // for this tripFeature
              final itemDocs = iniTripFeature.items.map((initialId) { // initialId is a value of "initialId" from items.json
                final itemDoc = itemDocInitialIds[initialId];
                if (itemDoc != null) {
                  return itemDoc;
                } else {
                  logError("Can't find DocumentReference for initialId = '$initialId'");
                  throw InconsistentInitialJsonDataError();
                }
              }).toList();
              tripAspectDoc.tripFeatureCollection
                  .add(iniTripFeature.toJson())
                  .then((tripFeatureDoc) => tripFeatureDoc.set({'items': itemDocs}, SetOptions(merge: true)));
            }
          });
    }
  }
}
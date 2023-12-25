import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

import '../../../../global/data/firestore_helpers.dart';
import '../../../../global/domain/models/trip/i_trip_repository.dart';
import '../../../../global/domain/models/trip/trip.dart';
import '../../../../global/domain/models/trip/trip_failure.dart';
import '../../../../utils/logging.dart';
import 'trip_dto.dart';

@LazySingleton(as: ITripRepository)
class TripRepository implements ITripRepository {
  final FirebaseFirestore _firestore;

  TripRepository(this._firestore);

  CollectionReference<TripDto> getTripCollectionRef(DocumentReference userDoc) =>
      userDoc.tripCollection
          .withConverter(
        fromFirestore: (snapshot, _) => TripDto.fromFirestore(snapshot),
        toFirestore: (tripDto, _) => tripDto.toJson(),
      );

  @override
  Stream<List<Trip>> watchAll() async* {
    final tripCollection = getTripCollectionRef(await _firestore.userDocument());
    yield* tripCollection
        .orderBy('dateCreated', descending: true)
        .snapshots() // it's optimized and cheaper than .getDocuments which always loads all the documents
        .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList())
        .onErrorReturnWith((e, stackTrace) => throw TripFailure.fromError(e));
  }

  @override
  Stream<List<Trip>> watchUncompleted() async* {
    final tripCollection = getTripCollectionRef(await _firestore.userDocument());
    yield* tripCollection
        .orderBy('dateCreated', descending: true)
        .snapshots() // it's optimized and cheaper than .getDocuments
        .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()))
        .map((trips) => trips.where((trip) => !trip.complete).toList())
        .onErrorReturnWith((e, stackTrace) => throw TripFailure.fromError(e));
  }

  @override
  Future<Trip> create(Trip trip) async {
      try {
        final userDoc = await _firestore.userDocument();
        final tripDto = TripDto.fromDomain(trip);
        await userDoc.tripCollection.doc(tripDto.id).set(tripDto.toJson());
        return trip; // todo id
      } catch (e) {
        logError("failed to create a trip $trip: $e");
        throw TripFailure.fromError(e);
      }
  }

  @override
  Future<Trip> update(Trip trip) async {
      try {
        final userDoc = await _firestore.userDocument();
        final tripDto = TripDto.fromDomain(trip);
        await userDoc.tripCollection.doc(tripDto.id).update(tripDto.toJson());
        return trip; // todo id
      } catch (e) {
        logError("failed to update a trip $trip: $e");
        throw TripFailure.fromError(e);
      }
  }

  @override
  Future<void> delete(Trip trip) async {
      try {
        final userDoc = await _firestore.userDocument();
        await userDoc.tripCollection.doc(trip.id).delete();
      } catch (e) {
        logError("failed to delete a trip $trip: $e");
        throw TripFailure.fromError(e);
      }
  }
}

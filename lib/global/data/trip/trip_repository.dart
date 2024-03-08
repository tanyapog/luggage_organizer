import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/transformers.dart';

import '../firestore_helpers.dart';
import '../../domain/models/trip/i_trip_repository.dart';
import '../../domain/models/trip/trip.dart';
import '../../domain/models/trip/trip_failure.dart';
import '../../../utils/logging/logging.dart';
import 'dto/trip_dto.dart';

@LazySingleton(as: ITripRepository)
class TripRepository implements ITripRepository {
  final FirebaseFirestore _firestore;

  TripRepository(this._firestore);

  Future<CollectionReference<TripDto>> _getCollectionRef() async {
    final userDoc = await _firestore.userDocument;
    return userDoc.tripAspectCollection.withConverter(
      fromFirestore: (snapshot, _) => TripDto.fromFirestore(snapshot),
      toFirestore: (tripDto, _) => tripDto.toJson(),
    );
  }

  @override
  Stream<List<Trip>> watchAll() async* {
    final tripCollection = await _getCollectionRef();
    yield* tripCollection
        .orderBy('dateCreated', descending: true)
        .snapshots() // it's optimized and cheaper than .getDocuments which always loads all the documents
        .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()).toList())
        .onErrorReturnWith((e, stackTrace) {
          logError("watchAll failed with $e");
          throw TripFailure.fromError(e);
        });
  }

  @override
  Stream<List<Trip>> watchUncompleted() async* {
    final tripCollection = await _getCollectionRef();
    yield* tripCollection
        .orderBy('dateCreated', descending: true)
        .snapshots() // it's optimized and cheaper than .getDocuments
        .map((snapshot) => snapshot.docs.map((doc) => doc.data().toDomain()))
        .map((trips) => trips.where((trip) => !trip.complete).toList())
        .onErrorReturnWith((e, stackTrace) {
          logError("watchUncompleted failed with $e");
          throw TripFailure.fromError(e);
        });
  }

  @override
  Future<Trip> create(Trip trip) async {
      try {
        final userDoc = await _firestore.userDocument;
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
        final userDoc = await _firestore.userDocument;
        final tripDto = TripDto.fromDomain(trip);
        await userDoc.tripCollection.doc(tripDto.id).update(tripDto.toJson());
        return trip; // todo id
      } catch (e) {
        logError("failed to update a trip $trip: $e");
        throw TripFailure.fromError(e);
      }
  }

  @override
  Future<Trip> switchCompleted(Trip trip) async =>
      await update(trip.copyWith(complete: !trip.complete));

  @override
  Future<void> delete(Trip trip) async {
      try {
        final userDoc = await _firestore.userDocument;
        await userDoc.tripCollection.doc(trip.id).delete();
      } catch (e) {
        logError("failed to delete a trip $trip: $e");
        throw TripFailure.fromError(e);
      }
  }
}

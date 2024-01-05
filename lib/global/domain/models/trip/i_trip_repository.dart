import 'trip.dart';

abstract class ITripRepository {
  Stream<List<Trip>> watchAll();
  Stream<List<Trip>> watchUncompleted();
  Future<Trip> create(Trip trip);
  Future<Trip> update(Trip trip);
  Future<Trip> switchCompleted(Trip trip);
  Future<void> delete(Trip trip);
}

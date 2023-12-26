part of 'trip_watcher_bloc.dart';

@freezed
class TripWatcherEvent with _$TripWatcherEvent {
  const factory TripWatcherEvent.watchAll() = _WatchAll;
  const factory TripWatcherEvent.watchUncompleted() = _WatchUncompleted;
}

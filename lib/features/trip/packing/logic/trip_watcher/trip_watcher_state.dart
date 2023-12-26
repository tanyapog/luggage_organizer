part of 'trip_watcher_bloc.dart';

@freezed
class TripWatcherState with _$TripWatcherState {
  const factory TripWatcherState.initial() = _Initial;
  const factory TripWatcherState.loading() = _Loading;
  const factory TripWatcherState.succeed(List<Trip> trips) = _Succeed;
  const factory TripWatcherState.failed(TripFailure tripFailure) = _Failed;
}

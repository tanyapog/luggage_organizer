part of 'trip_watcher_bloc.dart';

enum Status { loading, success, failure }

@freezed
class TripWatcherState with _$TripWatcherState {
  const factory TripWatcherState({
    List<Trip>? trips,
    @Default(true) bool showUncompleted,
    @Default(Status.loading) Status status,
    String? errorMessage,
  }) = _State;
}

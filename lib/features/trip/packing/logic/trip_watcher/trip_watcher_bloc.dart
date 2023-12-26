import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../global/domain/models/trip/i_trip_repository.dart';
import '../../../../../global/domain/models/trip/trip.dart';
import '../../../../../global/domain/models/trip/trip_failure.dart';

part 'trip_watcher_event.dart';
part 'trip_watcher_state.dart';
part 'trip_watcher_bloc.freezed.dart';

@injectable
class TripWatcherBloc extends Bloc<TripWatcherEvent, TripWatcherState> {
  final ITripRepository _tripRepository;

  TripWatcherBloc(this._tripRepository) : super(const TripWatcherState.initial()){
    on<TripWatcherEvent>(
          (event, emit) => event.map(
        watchAll: (event) async {
          emit(const TripWatcherState.loading());
          await emit.forEach<List<Trip>>(
            _tripRepository.watchAll(),
            onData: (trips) => TripWatcherState.succeed(trips),
            onError: (e, stackTrace) => TripWatcherState.failed(TripFailure.fromError(e)),
          );
          return null;
        },
        watchUncompleted: (event) async {
          emit(const TripWatcherState.loading());
          await emit.forEach<List<Trip>>(
            _tripRepository.watchUncompleted(),
            onData: (trips) => TripWatcherState.succeed(trips),
            onError: (e, stackTrace) => TripWatcherState.failed(TripFailure.fromError(e)),
          );
          return null;
        },
      ),
      transformer: restartable(),
    );
  }
}

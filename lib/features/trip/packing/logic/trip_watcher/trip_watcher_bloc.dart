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

  TripWatcherBloc(this._tripRepository) : super(const TripWatcherState()){
    on<TripWatcherEvent>((event, emit) => event.map(
        watchAll: (event) async {
          emit(state.copyWith(status: Status.loading, errorMessage: null));
          await emit.forEach<List<Trip>>(
            _tripRepository.watchAll(),
            onData: (trips) => TripWatcherState(
              showUncompleted: true,
              trips: trips,
              status: Status.success,
              errorMessage: null,
            ),
            onError: (e, stackTrace) => TripWatcherState(
              showUncompleted: true,
              status: Status.failure,
              errorMessage: TripFailure.fromError(e).message,
            ),
          );
          return null;
        },
        watchUncompleted: (event) async {
          emit(state.copyWith(status: Status.loading, errorMessage: null));
          await emit.forEach<List<Trip>>(
            _tripRepository.watchUncompleted(),
            onData: (trips) => TripWatcherState(
              showUncompleted: false,
              trips: trips,
              status: Status.success,
              errorMessage: null,
            ),
            onError: (e, stackTrace) => TripWatcherState(
              showUncompleted: false,
              status: Status.failure,
              errorMessage: TripFailure.fromError(e).message,
            ),
          );
          return null;
        },
      ),
      transformer: restartable(),
    );
  }
}

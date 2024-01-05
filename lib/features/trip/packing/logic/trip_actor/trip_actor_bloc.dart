import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../global/domain/models/trip/i_trip_repository.dart';
import '../../../../../global/domain/models/trip/trip.dart';
import '../../../../../global/domain/models/trip/trip_failure.dart';

part 'trip_actor_event.dart';
part 'trip_actor_state.dart';
part 'trip_actor_bloc.freezed.dart';

@injectable
class TripActorBloc extends Bloc<TripActorEvent, TripActorState> {
  final ITripRepository _tripRepository;

  TripActorBloc(this._tripRepository) : super(const TripActorState.initial()) {
    on<TripActorEvent>((event, emit)  async {
        emit(const TripActorState.actionInProgress());
        try {
          await _tripRepository.switchCompleted(event.trip);
          emit(const TripActorState.markAsCompletedSucceed());
        } on TripFailure catch (e) {
          emit(TripActorState.markAsCompletedFailed(e.message));
        } on Exception catch (e) {
          emit(TripActorState.markAsCompletedFailed(e.toString()));
        }
      },
      transformer: concurrent(),
    );
  }
}

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

const _debounceDuration = Duration(milliseconds: 100);

/// Adds a delay in checking for a new event.
/// duration = 100 ms if not specified
EventTransformer<Event> debounceRestartable<Event>({Duration? duration}) =>
        (events, mapper) => restartable<Event>()
        .call(events.debounceTime(duration ?? _debounceDuration), mapper);

/// Add a delay in checking for a new sequential event to occur
/// in order not to check the input field for each letter entered, for example.
/// duration = 100 ms if not specified.
EventTransformer<E> debounceSequential<E>({Duration? duration}) =>
        (events, mapper) => sequential<E>()
        .call(events.debounceTime(duration ?? _debounceDuration), mapper);
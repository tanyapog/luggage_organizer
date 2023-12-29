import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/logic/sign_in_form/sign_in_form_bloc.dart';
import 'logging.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logBloc(
        bloc,
        'onChange(${bloc.runtimeType}\n'
            'New state ${change.nextState}\n'
            'Previous state ${change.currentState})');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logBloc(bloc, 'onCreate(${bloc.runtimeType}\nInitial state ${bloc.state})');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logBloc(bloc, 'onError(${bloc.runtimeType}, $error, $stackTrace)', );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logBloc(bloc, 'onClose(${bloc.runtimeType}\nInitial state ${bloc.state})');
  }

  void _logBloc(BlocBase bloc, String message, {Object? error, StackTrace? stackTrace}) {
    if (bloc is SignInFormBloc) return; // do not log privat information
    error == null
        ? logData(message)
        : logError(message, exception: error, stackTrace: stackTrace);
  }
}

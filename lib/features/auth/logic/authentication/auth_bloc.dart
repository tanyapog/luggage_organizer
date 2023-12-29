import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../global/domain/models/user/i_auth_facade.dart';
import '../../../../utils/logging/logging.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _auth;

  AuthBloc(this._auth) : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) => event.map(
        authCheckRequested: (event) async {
          emit(_auth.isAuthorized ? AuthState.authenticated() : AuthState.unauthenticated());
          return null;
        },
        signedOut: (event) async {
          _auth.signOut();
          logData("User logged out");
          emit(AuthState.unauthenticated());
          return null;
        },
      ),
      transformer: sequential(),
    );
  }
}

part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({required AuthStatus authStatus}) = _AuthState;

  factory AuthState.initial() => const AuthState(authStatus: AuthStatus.unknown);
  factory AuthState.authenticated() => const AuthState(authStatus: AuthStatus.authenticated);
  factory AuthState.unauthenticated() => const AuthState(authStatus: AuthStatus.unauthenticated);
}

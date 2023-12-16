import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure({required String message}) = _AuthFailure;
  factory AuthFailure.cancelledByUser() => const AuthFailure(message: "Cancelled by user");
  // Serves as a "catch all" failure if we don't know what exactly went wrong
  factory AuthFailure.serverError(String message) => AuthFailure(message: message);
  factory AuthFailure.emailAlreadyInUse() => const AuthFailure(message: " Email already in use");
  factory AuthFailure.invalidEmailAndPasswordCombination() => const AuthFailure(message: " Invalid email and password combination");
}
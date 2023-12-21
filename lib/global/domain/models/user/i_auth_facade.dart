import 'user.dart';

abstract class IAuthFacade {
  User? get signedInUser;
  bool get isAuthorized;

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
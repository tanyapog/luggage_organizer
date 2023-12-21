import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../global/domain/models/user/i_auth_facade.dart';
import '../../../global/domain/models/user/user.dart';
import 'auth_failure.dart';
import 'firebase_user_mapper.dart';

/// Provides signedIn user if any.
/// Responsible for all auth actions like registering, signing in and out through Firebase.
/// Can throw an [AuthFailure].
@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  User? get signedInUser => _firebaseAuth.currentUser?.toDomain();

  @override
  bool get isAuthorized => signedInUser != null;

  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.code == 'email-already-in-use'
          ? AuthFailure.emailAlreadyInUse()
          : AuthFailure.serverError("${e.code}: ${e.message}");
    } on Exception catch (e) {
      throw AuthFailure.serverError("Unknown exception: $e");
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw (e.code == 'wrong-password' || e.code == 'user-not-found')
          ? AuthFailure.invalidEmailAndPasswordCombination()
          : AuthFailure.serverError("${e.code}: ${e.message}");
    } on Exception catch (e) {
      throw AuthFailure.serverError(e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
         throw AuthFailure.cancelledByUser();
      }
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      _firebaseAuth.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.serverError("${e.code}: ${e.message}");
    } catch (e) {
      throw AuthFailure.serverError(e.toString());
    }
  }

  @override
  Future<void> signOut() => Future.wait([
    _googleSignIn.signOut(),
    _firebaseAuth.signOut(),
  ]);
}

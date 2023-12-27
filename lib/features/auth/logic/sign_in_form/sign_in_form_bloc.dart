import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../global/domain/models/user/i_auth_facade.dart';
import '../../../../utils/event_transformers.dart';
import '../../../../utils/logging.dart';
import '../../data/auth_failure.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {

    on<EmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email, isSubmitting: false, success: null, errorMessage: null)),
      transformer: debounceRestartable(),
    );

    on<PasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password, isSubmitting: false, success: null, errorMessage: null)),
      transformer: debounceRestartable(),
    );

    on<RegisterWithEmailAndPasswordPressed>(
      (event, emit) async => _performAuthAction(emit, emailAuthAction: _authFacade.registerWithEmailAndPassword),
      transformer: debounceSequential(),
    );

    on<SignInWithEmailAndPasswordPressed>(
      (event, emit) async => _performAuthAction(emit, emailAuthAction: _authFacade.signInWithEmailAndPassword),
      transformer: debounceSequential(),
    );

    on<SignInWithGooglePressed>(
      (event, emit) async => _performAuthAction(emit, thirdPartyAuth: _authFacade.signInWithGoogle),
      transformer: debounceSequential(),
    );
  }

  Future<void> _performAuthAction(Emitter<SignInFormState> emit, {
      Future<void> Function({required String email, required String password})? emailAuthAction,
      Future<void> Function()? thirdPartyAuth,
  }) async {
    emit(_copyStateWithSubmitting());
    try {
      if (emailAuthAction != null) {
        await emailAuthAction(
          email: state.email,
          password: state.password,
        );
      } else if (thirdPartyAuth != null) {
        await thirdPartyAuth();
      }
    } on AuthFailure catch (e) {
      logError("AuthFailure: ${e.message}");
      emit(_copyStateWithError(e.message));
    } catch (e) {
      logError("Unexpected error occurred: $e");
      emit(_copyStateWithError("Unexpected error: $e"));
    }
    if (_authFacade.isAuthorized) {
      logData("User ${_authFacade.signedInUser!.email} is successfully authorized");
      emit(_copyStateWithSuccess());
    }
  }

  SignInFormState _copyStateWithSubmitting() => state.copyWith(
    isSubmitting: true,
    success: null,
    errorMessage: null,
  );

  SignInFormState _copyStateWithSuccess() => state.copyWith(
    isSubmitting: false,
    success: true,
    errorMessage: null,
  );

  SignInFormState _copyStateWithError(String message) => state.copyWith(
    isSubmitting: false,
    success: false,
    errorMessage: message,
  );
}


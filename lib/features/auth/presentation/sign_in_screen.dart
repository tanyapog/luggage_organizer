import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luggage_organizer/global/presentation/theme/app_colors.dart';
import 'package:luggage_organizer/global/presentation/validator.dart';

import '../../../global/presentation/theme/app_input.dart';
import '../../../injection.dart';
import '../logic/sign_in_form/sign_in_form_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => getIt<SignInFormBloc>(),
        child: const SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  // this key should be static, otherwise it makes keyboard disappearing when focusing on TextFormField
  static final GlobalKey<FormState> _globalSignInFormKey = GlobalKey<FormState>();

  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {},
      builder: (context, state) =>
          Form(
            key: _globalSignInFormKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: <Widget>[
                  const SizedBox(height: 24),
                  const Text('Luggage Organizer', textAlign: TextAlign.center, style: TextStyle(fontSize: 36, color: AppColors.primary)),
                  const SizedBox(height: 80),
                  TextFormField(
                    onChanged: (value) => context.read<SignInFormBloc>()
                        .add(SignInFormEvent.emailChanged(value)),
                    validator: (value) => Validator.isEmail(value),
                    autocorrect: false,
                    decoration: AppInputDecoration.roundedBorder.copyWith(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: AppColors.grey50),
                      prefixIcon: const Icon(Icons.email, color: AppColors.iconColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) => context.read<SignInFormBloc>()
                        .add(SignInFormEvent.passwordChanged(value)),
                    validator: (value) => Validator.isPasswordValid(value),
                    autocorrect: false,
                    decoration: AppInputDecoration.roundedBorder.copyWith(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color:AppColors.grey50),
                      prefixIcon: const Icon(Icons.lock, color: AppColors.iconColor),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            _globalSignInFormKey.currentState?.validate();
                            context.read<SignInFormBloc>()
                                .add(const SignInFormEvent.signInWithEmailAndPasswordPressed());
                          },
                          child: const Text('SIGN IN', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            _globalSignInFormKey.currentState?.validate();
                            context.read<SignInFormBloc>()
                                .add(const SignInFormEvent.registerWithEmailAndPasswordPressed());
                          },
                          child: const Text('REGISTER', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => context.read<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed()),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.button),
                    child: const Text('SIGN IN WITH GOOGLE', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                  ),
                  if (state.isSubmitting) ... [
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(),
                  ]
                ],
              ),
            ),
          ),
    );
  }
}
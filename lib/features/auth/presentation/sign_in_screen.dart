import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luggage_organizer/global/presentation/theme/app_colors.dart';
import 'package:luggage_organizer/global/presentation/theme/app_padding.dart';
import 'package:luggage_organizer/global/presentation/validator.dart';

import '../../../global/presentation/messages.dart';
import '../../../global/presentation/theme/app_input.dart';
import '../../../global/presentation/widgets/box.dart';
import '../../../injection.dart';
import '../logic/authentication/auth_bloc.dart';
import '../logic/sign_in_form/sign_in_form_bloc.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => getIt<SignInFormBloc>(),
        child: const _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatelessWidget {
  // this key should be static, otherwise it makes keyboard disappearing when focusing on TextFormField
  static final GlobalKey<FormState> _globalSignInFormKey = GlobalKey<FormState>();

  const _SignInForm();

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<SignInFormBloc>();

    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listenWhen: (previous, current) => previous.success != current.success,
      listener: (context, state) {
        if (state.success != null) {
          state.success!
              ? context.read<AuthBloc>().add(const AuthEvent.authCheckRequested())
              : showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) => Form(
        key: _globalSignInFormKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            padding: AppPadding.horizontal,
            children: <Widget>[
              Box.s24,
              const Text('Luggage Organizer', textAlign: TextAlign.center, style: TextStyle(fontSize: 36, color: AppColors.primary)),
              Box.s80,
              TextFormField(
                onChanged: (value) => bloc.add(SignInFormEvent.emailChanged(value)),
                validator: (value) => Validator.isEmail(value),
                autocorrect: false,
                decoration: AppInputDecoration.roundedBorder.copyWith(
                  contentPadding: AppPadding.vertical15,
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: AppColors.grey50),
                  prefixIcon: const Icon(Icons.email, color: AppColors.iconColor),
                ),
              ),
              Box.s8,
              TextFormField(
                onChanged: (value) => bloc.add(SignInFormEvent.passwordChanged(value)),
                obscureText: true,
                validator: (value) => Validator.isPasswordValid(value),
                autocorrect: false,
                decoration: AppInputDecoration.roundedBorder.copyWith(
                  contentPadding: AppPadding.vertical15,
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
                Box.s8,
                const LinearProgressIndicator(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
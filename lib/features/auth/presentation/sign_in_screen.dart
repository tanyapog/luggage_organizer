import 'package:flutter/material.dart';
import 'package:luggage_organizer/global/presentation/theme/app_colors.dart';

import '../../../global/presentation/theme/app_input.dart';
import '../../../global/presentation/validator.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SignInForm(),
    );
  }
}

class SignInForm extends StatelessWidget {
  // this key should be static, otherwise it makes keyboard disappearing when focusing on TextFormField
  static final GlobalKey<FormState> _globalSignInFormKey = GlobalKey<FormState>();

  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    onPressed: () => _globalSignInFormKey.currentState?.validate(),
                    child: const Text('SIGN IN', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () => _globalSignInFormKey.currentState?.validate(),
                    child: const Text('REGISTER', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.button),
              child: const Text('SIGN IN WITH GOOGLE', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
/// Validators for form field values
/// Return null if value is valid and error message if value is invalid
class Validator {
  static const int passwordLength = 6;
  static const String emptyFieldError = "The field can not be empty";
  static const String invalidEmailError = "Email is invalid";
  static const String invalidPasswordError = "Password must contain at least $passwordLength characters";

  static String? isNotEmpty(String? value) {
    if (value == null || value.isEmpty) return emptyFieldError;
    final visibleSymbolsOnly = value.replaceAll(RegExp(r"\s+\b|\b\s|\s|\b"), "");
    return (visibleSymbolsOnly.isEmpty) ? emptyFieldError : null;
  }

  static bool _emailIsInvalid(String value) => (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value));

  static String? isEmail(String? value) => isNotEmpty(value) ?? (_emailIsInvalid(value!) ? invalidEmailError : null);

  static String? isPasswordValid(String? value) => isNotEmpty(value) ?? (value!.length < passwordLength ? invalidPasswordError : null);
}
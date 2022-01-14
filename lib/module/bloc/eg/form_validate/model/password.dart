import 'package:formz/formz.dart';

enum PasswordInvalidError {
  invalidate,
}

class Password extends FormzInput<String, PasswordInvalidError> {
  const Password.pure([String value = '']) : super.pure(value);

  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordInvalidError? validator(String? value) {
    if (_passwordRegex.hasMatch(value ?? "")) {
      return null;
    } else {
      return PasswordInvalidError.invalidate;
    }
  }
}

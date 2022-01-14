import 'package:formz/formz.dart';

enum EmailInvalidateError { invalidate }

class Email extends FormzInput<String, EmailInvalidateError> {
  const Email.pure([String value = '']) : super.pure(value);

  const Email.dirty(value) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailInvalidateError? validator(String? value) {
    if (_emailRegex.hasMatch(value ?? "")) {
      return null;
    } else {
      return EmailInvalidateError.invalidate;
    }
  }
}

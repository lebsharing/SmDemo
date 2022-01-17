import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sm/module/bloc/eg/form_validate/model/email.dart';
import 'package:sm/module/bloc/eg/form_validate/model/password.dart';

class MyFormState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const MyFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  MyFormState copyWith(
      {Email? email, Password? password, FormzStatus? status}) {
    return MyFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password,status];
}

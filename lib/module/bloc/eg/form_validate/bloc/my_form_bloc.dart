import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:sm/module/bloc/eg/form_validate/model/email.dart';
import 'package:sm/module/bloc/eg/form_validate/model/password.dart';

import 'my_form_event.dart';
import 'my_form_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc(initialState) : super(initialState) {
    on<EmailChangedEvent>(_emailChanged);
    on<EmailUnFocusEvent>(_emailUnFocus);
    on<PasswordChangedEvent>(_PwdChanged);
    on<PasswordUnFocusEvent>(_PwdFocus);
    on<FormSubmitEvent>(_formSubmitEvent);
  }

  _emailChanged(EmailChangedEvent event, Emitter<MyFormState> emit) {
    Email email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.valid ? email : Email.pure(email.value),
      status: Formz.validate([email, state.password]),
    ));
  }

  _emailUnFocus(EmailUnFocusEvent event, Emitter<MyFormState> emit) {
    Email email = Email.dirty(state.email.value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  _PwdChanged(PasswordChangedEvent event, Emitter<MyFormState> emit) {
    Password pwd = Password.dirty(event.password);
    emit(state.copyWith(
      password: pwd.valid ? pwd : Password.pure(event.password),
      status: Formz.validate([state.email, pwd]),
    ));
  }

  _PwdFocus(PasswordUnFocusEvent event, Emitter<MyFormState> emit) {
    Password pwd = Password.dirty(state.password.value);
    emit(state.copyWith(
        password: pwd, status: Formz.validate([state.email, pwd])));
  }

  _formSubmitEvent(FormSubmitEvent event,Emitter<MyFormState> emit) async {
    Email email = Email.dirty(state.email.value);
    Password password = Password.dirty(state.password.value);
    emit(state.copyWith(email: email,password: password,status: Formz.validate([email,password])));
    print("===${state.status.isValidated}");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }

  @override
  void onTransition(Transition<MyFormEvent, MyFormState> transition) {
    super.onTransition(transition);
    print("--MyFormBloc--onTransition   $transition");
  }

  @override
  void onEvent(event) {
    super.onEvent(event);
    print("--MyFormBloc--onEvent    $event");
  }

  @override
  void onChange(Change<MyFormState> change) {
    super.onChange(change);
    print("--MyFormBloc--onChange  $change");
  }
}

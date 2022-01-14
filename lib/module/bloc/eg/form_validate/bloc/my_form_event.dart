class MyFormEvent {}

class EmailChangedEvent extends MyFormEvent {
  final String email;

  EmailChangedEvent(this.email);
}

class EmailUnFocusEvent extends MyFormEvent {}

class PasswordChangedEvent extends MyFormEvent {
  final String password;

  PasswordChangedEvent(this.password);
}

class PasswordUnFocusEvent extends MyFormEvent {}

class FormSubmitEvent extends MyFormEvent {

}
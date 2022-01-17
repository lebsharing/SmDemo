import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc/my_form_bloc.dart';
import 'bloc/my_form_event.dart';
import 'bloc/my_form_state.dart';

///以Form的形式演示Bloc+FlutterBloc的使用
class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
      ),
      body: BlocProvider(
        create: (ctx) {
          return MyFormBloc(const MyFormState());
        },
        child: const _BodyContent(),
      ),
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent({Key? key}) : super(key: key);

  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> {
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _pwdFocusNode = FocusNode();
  String info =
      "以Form的形式演示Bloc+FlutterBloc的使用方式,包含了BlocProvider、Bloc、BlocBuilder、BlocListener";

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(EmailUnFocusEvent());
      }
    });
    _pwdFocusNode.addListener(() {
      if (!_pwdFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(PasswordUnFocusEvent());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _pwdFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFormBloc, MyFormState>(
      listener: (ctx, state) {
        print("===listener:$state");
        if (state.status == FormzStatus.submissionInProgress) {
          ScaffoldMessenger.of(ctx)
              .showSnackBar(const SnackBar(content: Text("Submitting...")));
        } else if (state.status == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
          showSuccessDialog(ctx);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "$info",
              style: TextStyle(fontSize: 18),
            ),
            _EmailWidget(focusNode: _emailFocusNode),
            _PasswordWidget(focusNode: _pwdFocusNode),
            _SubmitButton(
              callback: () {
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (bContext) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("恭喜您，登陆成功"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(bContext).pop();
              },
              child: const Text("Confirm"),
            )
          ],
        );
      },
    );
  }
}

class _EmailWidget extends StatelessWidget {
  final FocusNode focusNode;

  const _EmailWidget({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (ctx, state) {
        print(
            "-email-${state.email.pure}  ${state.email.valid}  ${state.email.invalid}");
        return TextFormField(
          initialValue: state.email.value,
          decoration: InputDecoration(
              icon: const Icon(Icons.email),
              labelText: "Email",
              // labelStyle: const TextStyle(color: Colors.blue),
              // hintText: "Please input eamil",
              helperText: "input email.eg: jike@gmil.com",
              errorText: state.email.invalid
                  ? "please ensure the input email is valid"
                  : ""),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            context.read<MyFormBloc>().add(EmailChangedEvent(value));
          },
          focusNode: focusNode,
        );
      },
    );
  }
}

class _PasswordWidget extends StatelessWidget {
  final FocusNode focusNode;

  const _PasswordWidget({Key? key, required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      builder: (ctx, state) {
        print(
            "-pwd:-${state.password.pure}  ${state.password.valid}  ${state.password.invalid}");
        return TextFormField(
          // obscureText: true,
          focusNode: focusNode,
          initialValue: state.password.value,
          decoration: InputDecoration(
              icon: const Icon(Icons.password),
              labelText: "Password",
              labelStyle: const TextStyle(color: Colors.blue),
              hintText: "Please input eamil",
              helperText: "input email.eg: jike@gmil.com",
              errorText: state.password.invalid
                  ? "Password must be at least 8 characters and contain at least one letter and number"
                  : ""),
          // keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            context.read<MyFormBloc>().add(PasswordChangedEvent(value));
          },
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final Function()? callback;

  const _SubmitButton({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFormBloc, MyFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (ctx, state) {
        print("--btn---${state.status.isValidated}");
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () {
                  context.read<MyFormBloc>().add(FormSubmitEvent());
                  if (callback != null) {
                    callback!();
                  }
                }
              : null,
          // onPressed: (){
          //   context.read<MyFormBloc>().add(FormSubmitEvent());
          // },
          child: const Text("Submit"),
        );
      },
    );
  }
}

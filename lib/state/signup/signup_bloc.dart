import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SignupBloc extends FormBloc<String, String> {
  final fullName = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final userName = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final email = TextFieldBloc(
    validators: [FieldBlocValidators.required, FieldBlocValidators.email],
  );
  final password = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.passwordMin6Chars
  ]);

  SignupBloc() {
    addFieldBlocs(fieldBlocs: [
      fullName,
      userName,
      email,
      password,
    ]);
  }
  String? profileImagePath;

  @override
  Future<void> onSubmitting() async {}

  @override
  Future<void> onCancelingSubmission() async {}

  @override
  Future<void> onDeleting() async {}

  @override
  Future<void> onLoading() async {}
}

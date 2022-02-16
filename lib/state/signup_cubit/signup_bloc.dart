import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SignupBloc extends FormBloc<String, String> {
  final TextFieldBloc<Validator<String?>> fullName =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
    ],
  );
  final TextFieldBloc<Validator<String?>> userName =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
    ],
  );
  final TextFieldBloc<Validator<String?>> email =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );
  final TextFieldBloc<Validator<String?>> password =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars
    ],
  );

  SignupBloc() {
    addFieldBlocs(
      fieldBlocs: <FieldBloc<FieldBlocStateBase>>[
        fullName,
        userName,
        email,
        password,
      ],
    );
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

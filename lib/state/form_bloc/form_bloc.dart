import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventCreationBlocForm extends FormBloc<String, String> {
  final InputFieldBloc<DateTime, Object> dateAndTime1 =
      InputFieldBloc<DateTime, Object>(
    initialValue: DateTime.now(),
    validators: <Validator<DateTime?>>[
      FieldBlocValidators.required,
    ],
  );
  final InputFieldBloc<DateTime, Object> dateAndTime2 =
      InputFieldBloc<DateTime, Object>(
    initialValue: DateTime.now().add(const Duration(days: 1)),
    validators: <Validator<DateTime?>>[
      FieldBlocValidators.required,
    ],
  );
  final InputFieldBloc<TimeOfDay, Object> timeonly1 =
      InputFieldBloc<TimeOfDay, Object>(
    initialValue: TimeOfDay.now(),
    validators: <Validator<TimeOfDay?>>[
      FieldBlocValidators.required,
    ],
  );

  final InputFieldBloc<TimeOfDay, Object> timeonly2 =
      InputFieldBloc<TimeOfDay, Object>(
    initialValue: TimeOfDay.now(),
    validators: <Validator<TimeOfDay?>>[
      FieldBlocValidators.required,
    ],
  );

  final TextFieldBloc<Validator<String?>> description =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
    ],
  );
  final TextFieldBloc<Validator<String?>> title =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
    ],
  );
  final TextFieldBloc<Validator<String?>> subtitle =
      TextFieldBloc<Validator<String?>>(
    validators: <Validator<String?>>[
      FieldBlocValidators.required,
    ],
  );
  late List<FieldBloc<FieldBlocStateBase>> _blocs;
  EventCreationBlocForm() {
    // ignore: always_specify_types
    _blocs = [
      dateAndTime1,
      dateAndTime2,
      timeonly1,
      timeonly2,
      title,
      subtitle,
      description,
    ];
    addFieldBlocs(fieldBlocs: _blocs);
  }
  String? profileImagePath;

  @override
  Future<void> onSubmitting() async {
    emitSubmitting();
    for (final FieldBloc<FieldBlocStateBase> val in _blocs) {
      if (val is InputFieldBloc) {
        if (val.value == null) {
          emitFailure();
          return;
        }
      } else if (val is TextFieldBloc) {
        if ( val.value == '') {
          emitFailure();
          return;
        }
      }
    }
    emitSuccess();
  }

  @override
  Future<void> onCancelingSubmission() async {}

  @override
  Future<void> onDeleting() async {}

  @override
  Future<void> onLoading() async {}
}

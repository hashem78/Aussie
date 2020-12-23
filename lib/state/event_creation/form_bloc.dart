import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventCreationBlocForm extends FormBloc<String, String> {
  final InputFieldBloc<DateTime, Object> dateAndTime1 =
      InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  final InputFieldBloc<DateTime, Object> dateAndTime2 =
      InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );
  final InputFieldBloc<TimeOfDay, Object> timeonly1 =
      InputFieldBloc<TimeOfDay, Object>(
    validators: [FieldBlocValidators.required],
  );

  final InputFieldBloc<TimeOfDay, Object> timeonly2 =
      InputFieldBloc<TimeOfDay, Object>(
    validators: [FieldBlocValidators.required],
  );

  final description = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final title = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final subtitle = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  List<FieldBloc> _blocs;
  EventCreationBlocForm() {
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
  String profileImagePath;

  @override
  void onSubmitting() {
    emitSubmitting();
    for (final val in _blocs) {
      if (val is InputFieldBloc) {
        if (val.value == null) {
          emitFailure();
          return;
        }
      } else if (val is TextFieldBloc) {
        if (val.value == null || val.value == "") {
          emitFailure();
          return;
        }
      }
    }
    emitSuccess();
  }
}

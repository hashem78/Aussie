import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class StartDateFormField extends StatelessWidget {
  const StartDateFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputFieldBloc<DateTime, Object> _formElement =
        context.select<EventCreationBlocForm, InputFieldBloc<DateTime, Object>>(
      (value) => value.dateAndTime1,
    );
    return DateTimeFieldBlocBuilder(
      dateTimeFieldBloc: _formElement,
      format: DateFormat.yMMMMEEEEd(),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      decoration: InputDecoration(
        labelText: getTranslation(context, "eventCreationStartingDateTitle"),
        filled: true,
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.date_range),
        hintText: getTranslation(context, "eventCreationStartingDateHint"),
      ),
    );
  }
}

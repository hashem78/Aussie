import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EndDateFormField extends StatelessWidget {
  const EndDateFormField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _formElement = context.select<EventCreationBlocForm, InputFieldBloc>(
        (value) => value.dateAndTime2);
    return DateTimeFieldBlocBuilder(
      dateTimeFieldBloc: _formElement,
      format: DateFormat.yMMMMEEEEd(),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      decoration: InputDecoration(
        labelText: 'End Date',
        filled: true,
        border: InputBorder.none,
        prefixIcon: Icon(Icons.date_range),
        hintText: "The date the event ends",
      ),
    );
  }
}

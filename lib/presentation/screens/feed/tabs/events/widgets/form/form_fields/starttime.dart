import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class StartTimeFormField extends StatelessWidget {
  const StartTimeFormField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _formElement = context.select<EventCreationBlocForm, InputFieldBloc>(
        (value) => value.timeonly1);
    return TimeFieldBlocBuilder(
      timeFieldBloc: _formElement,
      format: DateFormat('hh:mm a'),
      initialTime: TimeOfDay.now(),
      decoration: InputDecoration(
        labelText: 'Starting Time',
        filled: true,
        border: InputBorder.none,
        hintText: "Time of day",
        prefixIcon: Icon(Icons.access_time),
      ),
    );
  }
}

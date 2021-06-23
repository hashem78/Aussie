import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EndTimeFormField extends StatelessWidget {
  const EndTimeFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final InputFieldBloc<TimeOfDay, Object> _formElement = context
        .select<EventCreationBlocForm, InputFieldBloc<TimeOfDay, Object>>(
      (value) => value.timeonly2,
    );
    return TimeFieldBlocBuilder(
      timeFieldBloc: _formElement,
      format: DateFormat('hh:mm a'),
      initialTime: TimeOfDay.now(),
      decoration: InputDecoration(
        labelText: getTranslation(context, "eventCreationEndingTimeTitle"),
        filled: true,
        border: InputBorder.none,
        hintText: getTranslation(context, "eventCreationEndingTimeHint"),
        prefixIcon: const Icon(Icons.access_time),
      ),
    );
  }
}

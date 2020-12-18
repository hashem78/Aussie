import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class SubtitleFormField extends StatelessWidget {
  const SubtitleFormField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _formElement = context.select<EventCreationBlocForm, TextFieldBloc>(
        (value) => value.subtitle);
    return TextFieldBlocBuilder(
      textFieldBloc: _formElement,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_pin),
          border: InputBorder.none,
          filled: true,
          labelText: getTranslation(context, "eventCreationSubtitleTitle"),
          hintText: getTranslation(context, "eventCreationSubtitleHint")),
    );
  }
}

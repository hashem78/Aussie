import 'package:aussie/aussie_imports.dart';
import 'package:flutter/material.dart';

class TitleFormField extends StatelessWidget {
  const TitleFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _formElement = context
        .select<EventCreationBlocForm, TextFieldBloc>((value) => value.title);
    return TextFieldBlocBuilder(
      textFieldBloc: _formElement,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_pin),
        border: InputBorder.none,
        filled: true,
        labelText: getTranslation(context, "eventCreationTitleTitle"),
        hintText: getTranslation(context, "eventCreationTitleHint"),
      ),
    );
  }
}

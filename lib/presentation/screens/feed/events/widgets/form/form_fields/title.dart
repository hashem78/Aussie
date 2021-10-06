import 'package:aussie/aussie_imports.dart';

class TitleFormField extends StatelessWidget {
  const TitleFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks, always_specify_types
    final TextFieldBloc _formElement = context
        // ignore: always_specify_types
        .select<EventCreationBlocForm, TextFieldBloc>(
      (EventCreationBlocForm value) {
        return value.title;
      },
    );
    return TextFieldBlocBuilder(
      textFieldBloc: _formElement,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_pin),
        border: InputBorder.none,
        filled: true,
        labelText: getTranslation(context, 'eventCreationTitleTitle'),
        hintText: getTranslation(context, 'eventCreationTitleHint'),
      ),
    );
  }
}

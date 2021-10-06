import 'package:aussie/aussie_imports.dart';

class SubtitleFormField extends StatelessWidget {
  const SubtitleFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks, always_specify_types
    final TextFieldBloc _formElement =
        // ignore: always_specify_types
        context.select<EventCreationBlocForm, TextFieldBloc>(
      (EventCreationBlocForm value) {
        return value.subtitle;
      },
    );
    return TextFieldBlocBuilder(
      textFieldBloc: _formElement,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person_pin),
          border: InputBorder.none,
          filled: true,
          labelText: getTranslation(context, 'eventCreationSubtitleTitle'),
          hintText: getTranslation(context, 'eventCreationSubtitleHint')),
    );
  }
}

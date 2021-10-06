import 'package:aussie/aussie_imports.dart';

class DescriptionFormField extends StatelessWidget {
  const DescriptionFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks, always_specify_types
    final TextFieldBloc _formElement =
        // ignore: always_specify_types
        context.select<EventCreationBlocForm, TextFieldBloc>(
      (EventCreationBlocForm value) => value.description,
    );
    return TextFieldBlocBuilder(
      textFieldBloc: _formElement,
      maxLines: null,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_pin),
        border: InputBorder.none,
        filled: true,
        labelText: getTranslation(context, 'eventCreationDescriptionTitle'),
        hintText: getTranslation(context, 'eventCreationDescriptionHint'),
      ),
    );
  }
}

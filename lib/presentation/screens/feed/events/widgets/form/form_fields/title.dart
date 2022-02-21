import 'package:aussie/aussie_imports.dart';

class TitleFormField extends StatelessWidget {
  const TitleFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(
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

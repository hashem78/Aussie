import 'package:aussie/aussie_imports.dart';

class DescriptionFormField extends StatelessWidget {
  const DescriptionFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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

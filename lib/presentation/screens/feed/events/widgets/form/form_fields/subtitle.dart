import 'package:aussie/aussie_imports.dart';

class SubtitleFormField extends StatelessWidget {
  const SubtitleFormField({
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
          labelText: getTranslation(context, 'eventCreationSubtitleTitle'),
          hintText: getTranslation(context, 'eventCreationSubtitleHint')),
    );
  }
}

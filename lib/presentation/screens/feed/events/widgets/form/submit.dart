import 'package:aussie/aussie_imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCreationSubmitButton extends ConsumerWidget {
  final bool enabled;
  const EventCreationSubmitButton({
    Key? key,
    required this.enabled,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // void _sn(String tid) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         getTranslation(context, tid),
    //       ),
    //     ),
    //   );
    // }

    return TextButton(
      onPressed: enabled ? () {} : null,
      child: Text(
        getTranslation(
          context,
          'eventCreationCreateEventButtonTitle',
        ),
      ),
    );
  }
}

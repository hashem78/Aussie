import 'package:aussie/aussie_imports.dart';
import 'package:aussie/state/image_picking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventImageGalleryPickerButton extends ConsumerWidget {
  const EventImageGalleryPickerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        ref.read(imagePickerProvier.notifier).pick(PickingMode.multi);
      },
      child: Text(getTranslation(context, 'eventCreationPickerButtonText')),
    );
  }
}

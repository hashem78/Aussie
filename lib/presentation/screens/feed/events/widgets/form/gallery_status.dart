import 'package:aussie/aussie_imports.dart';
import 'package:aussie/state/image_picking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventImageGalleryStatus extends ConsumerWidget {
  const EventImageGalleryStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickerStatus = ref.watch(imagePickerProvier);
    return pickerStatus.when(
      picked: (paths, byteData) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
            Text(getTranslation(context, 'eventCreationMultiImageError')),
          ],
        );
      },
      notPicked: () {
        return const SizedBox();
      },
    );
  }
}

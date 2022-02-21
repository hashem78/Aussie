import 'package:aussie/aussie_imports.dart';
import 'package:aussie/state/image_picking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventBannerPicker extends ConsumerWidget {
  const EventBannerPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(imagePickerProvier);
    return imageState.when(
      picked: (_, byteData) {
        return Ink.image(
          image: MemoryImage(
            byteData.first,
          ),
          fit: BoxFit.cover,
        );
      },
      notPicked: () {
        return const SizedBox();
      },
    );
  }
}

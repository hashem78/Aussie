import 'package:evento/presentation/screens/feed/events/widgets/form/widgets/event_creation_section_title.dart';
import 'package:evento/state/image_picking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';

class EventCreationBannerPicker extends ConsumerWidget {
  const EventCreationBannerPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePicker = ref.watch(imagePickerProvier(PickerUse.banner));

    return Column(
      children: [
        const EventCreationSectionTitle(
          text: 'Banner',
          iconData: Icons.image,
        ),
        SizedBox(
          height: .02.sh,
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(
            color: Colors.black.withOpacity(0.05),
            child: imagePicker.when(
              picked: (images) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.memory(images.first.byteData),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ref
                                .read(
                                  imagePickerProvier(PickerUse.banner).notifier,
                                )
                                .remove(0);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              notPicked: () {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(imagePickerProvier(PickerUse.banner).notifier)
                        .pick(
                      PickingMode.single,
                      shouldCrop: true,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.ratio16x9,
                      ],
                    );
                  },
                  child: const Center(
                    child: Text('Tap to select a banner'),
                  ),
                );
              },
              error: () {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(imagePickerProvier(PickerUse.banner).notifier)
                        .pick(
                      PickingMode.single,
                      shouldCrop: true,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.ratio16x9,
                      ],
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You have to add a banner to your event.',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 0.01.sh),
                      const Text('Tap to select a banner'),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
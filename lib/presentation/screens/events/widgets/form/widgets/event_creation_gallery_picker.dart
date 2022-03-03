import 'package:evento/presentation/screens/events/widgets/form/widgets/event_creation_section_title.dart';
import 'package:evento/state/image_picking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

class EventCreationGalleryPicker extends ConsumerWidget {
  const EventCreationGalleryPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryPicker = ref.watch(
      imagePickerProvier(PickerUse.gallery),
    );
    return GestureDetector(
      onTap: () {
        ref.read(imagePickerProvier(PickerUse.gallery).notifier).pick(
          PickingMode.multi,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
        );
      },
      child: Column(
        children: [
          const EventCreationSectionTitle(
            text: 'Gallery',
            iconData: Icons.photo_library,
          ),
          SizedBox(
            height: .02.sh,
          ),
          Container(
            height: 0.5.sh,
            color: Colors.black.withOpacity(0.05),
            child: galleryPicker.when(
              picked: (images) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(
                            images[index].byteData,
                            fit: BoxFit.cover,
                          ),
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
                                        imagePickerProvier(PickerUse.gallery)
                                            .notifier,
                                      )
                                      .remove(index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: images.length,
                );
              },
              notPicked: () {
                return const Center(
                  child: Text('Tap to add images to event'),
                );
              },
              error: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You have to add at least one image to your gallery.',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    const Text('Tap to add images to event'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

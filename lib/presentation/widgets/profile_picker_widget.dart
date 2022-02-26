import 'package:evento/state/image_picking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImagePickerWidget extends ConsumerWidget {
  const ProfileImagePickerWidget({
    Key? key,
    required this.pickerUse,
  }) : super(key: key);
  final PickerUse pickerUse;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = ref.watch(imagePickerProvier(pickerUse));

    return Center(
      child: CircleAvatar(
        radius: 90,
        child: profileImage.whenOrNull(
          picked: (images) {
            return Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: MemoryImage(images.first.byteData),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          notPicked: () {
            return const Icon(
              Icons.account_circle,
              size: 180,
            );
          },
        )!,
      ),
    );
  }
}

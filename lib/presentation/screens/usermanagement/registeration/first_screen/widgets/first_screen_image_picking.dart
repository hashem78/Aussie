import 'package:aussie/presentation/widgets/profile_picker_widget.dart';
import 'package:aussie/state/image_picking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

class FirstRegistrationScreenImagePickingWidget extends HookConsumerWidget {
  const FirstRegistrationScreenImagePickingWidget({
    Key? key,
    required this.showProfilePictureError,
  }) : super(key: key);

  final ValueNotifier<bool> showProfilePictureError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (useValueListenable(showProfilePictureError))
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Choose a profile picture',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        else
          const SizedBox(),
        GestureDetector(
          onTap: () {
            ref.read(imagePickerProvier(PickerUse.signup).notifier).pick(
                  PickingMode.single,
                  shouldCrop: true,
                  cropStyle: CropStyle.circle,
                );
            showProfilePictureError.value =
                ref.read(imagePickerProvier(PickerUse.signup)).when(
                      picked: (_) => true,
                      notPicked: (() => false),
                      error: (() => false),
                    );
          },
          child: const ProfileImagePickerWidget(
            pickerUse: PickerUse.signup,
          ),
        ),
      ],
    );
  }
}

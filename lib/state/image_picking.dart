import 'dart:io';
import 'dart:typed_data';

import 'package:aussie/aussie_imports.dart';
import 'package:aussie/models/image_picking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

enum PickingMode { single, multi }

class ImagePickingNotifier extends StateNotifier<ImagePickingState> {
  ImagePickingNotifier() : super(const ImagePickingState.notPicked());
  static final _picker = ImagePicker();
  static final _cropper = ImageCropper();

  static Future<File?> cropImage({
    required String path,
    CropAspectRatio? aspectRatio,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    required CropStyle cropStyle,
  }) async {
    return await _cropper.cropImage(
      sourcePath: path,
      aspectRatioPresets:
          aspectRatioPresets ?? const [CropAspectRatioPreset.ratio3x2],
      aspectRatio: aspectRatio,
      cropStyle: cropStyle,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.blue,
        hideBottomControls: true,
      ),
    );
  }

  Future<void> pick(
    PickingMode mode, {
    ImageSource source = ImageSource.gallery,
    bool shouldCrop = false,
    CropAspectRatio? aspectRatio,
    CropStyle cropStyle = CropStyle.rectangle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
  }) async {
    if (mode == PickingMode.single) {
      final img = await _picker.pickImage(source: source);
      if (img != null) {
        print('picked image is not null');
        if (shouldCrop) {
          final croppedImg = await cropImage(
            path: img.path,
            aspectRatio: aspectRatio,
            cropStyle: cropStyle,
            aspectRatioPresets: aspectRatioPresets,
          );
          if (croppedImg != null) {
            state = ImagePickingState.picked(
              [croppedImg.path],
              [await croppedImg.readAsBytes()],
            );
          }
        } else {
          state = ImagePickingState.picked(
            [img.path],
            [await img.readAsBytes()],
          );
        }
      }
    } else {
      final imgs = await _picker.pickMultiImage();
      if (imgs != null) {
        if (shouldCrop) {
          final croppedImagesPaths = <String>[];
          final croppedImagesByteData = <Uint8List>[];
          for (final img in imgs) {
            final croppedImg = await cropImage(
              path: img.path,
              aspectRatio: aspectRatio,
              cropStyle: cropStyle,
              aspectRatioPresets: aspectRatioPresets,
            );

            if (croppedImg != null) {
              croppedImagesPaths.add(croppedImg.path);
              croppedImagesByteData.add(await croppedImg.readAsBytes());
            }
          }
          state = ImagePickingState.picked(
            croppedImagesPaths,
            croppedImagesByteData,
          );
        } else {
          state = ImagePickingState.picked(
            imgs.map((e) => e.path).toList(),
            await Future.wait(imgs.map((e) => e.readAsBytes()).toList()),
          );
        }
      } else {
        state = const ImagePickingState.notPicked();
      }
    }
  }
}

final imagePickerProvier =
    StateNotifierProvider.autoDispose<ImagePickingNotifier, ImagePickingState>(
  (ref) {
    return ImagePickingNotifier();
  },
);

import 'dart:io';
import 'dart:typed_data';

import 'package:aussie/aussie_imports.dart';
import 'package:aussie/models/image_picking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

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

  Future<List<int>> getWidthHeight(Uint8List bytes) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    return [descriptor.width, descriptor.height];
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
            final bytes = await croppedImg.readAsBytes();
            final wh = await getWidthHeight(bytes);

            state = ImagePickingState.picked(
              [
                ImageWithAttributes(
                  path: croppedImg.path,
                  width: wh[0],
                  height: wh[1],
                  byteData: bytes,
                ),
              ],
            );
          }
        } else {
          final bytes = await img.readAsBytes();
          final wh = await getWidthHeight(bytes);
          state = ImagePickingState.picked(
            [
              ImageWithAttributes(
                path: img.path,
                width: wh[0],
                height: wh[1],
                byteData: bytes,
              ),
            ],
          );
        }
      }
    } else {
      final imgs = await _picker.pickMultiImage();
      if (imgs != null) {
        if (shouldCrop) {
          final croppedImages = <ImageWithAttributes>[];

          for (final img in imgs) {
            final croppedImg = await cropImage(
              path: img.path,
              aspectRatio: aspectRatio,
              cropStyle: cropStyle,
              aspectRatioPresets: aspectRatioPresets,
            );

            if (croppedImg != null) {
              final bytes = await croppedImg.readAsBytes();
              final wh = await getWidthHeight(bytes);
              croppedImages.add(
                ImageWithAttributes(
                    path: img.path,
                    width: wh[0],
                    height: wh[1],
                    byteData: bytes),
              );
            }
          }

          state = state.when(
            picked: (val) {
              return ImagePickingState.picked([...val, ...croppedImages]);
            },
            notPicked: () {
              return ImagePickingState.picked(croppedImages);
            },
            error: () {
              return ImagePickingState.picked(croppedImages);
            },
          );
        } else {
          final images = <ImageWithAttributes>[];
          for (final img in imgs) {
            final bytes = await img.readAsBytes();
            final wh = await getWidthHeight(bytes);
            images.add(
              ImageWithAttributes(
                path: img.path,
                width: wh[0],
                height: wh[1],
                byteData: bytes,
              ),
            );
          }

          state = state.when(picked: (val) {
            return ImagePickingState.picked(
              [...val, ...images],
            );
          }, notPicked: () {
            return ImagePickingState.picked(images);
          }, error: () {
            return ImagePickingState.picked(images);
          });
        }
      }
    }
  }

  void remove(int index) {
    state = state.whenOrNull(
      picked: (images) {
        if (images.length == 1) {
          return const ImagePickingState.notPicked();
        } else {
          images.removeAt(index);
          return ImagePickingState.picked(images);
        }
      },
      notPicked: () => const ImagePickingState.notPicked(),
    )!;
  }

  bool validate() {
    return state.when(
      picked: (_) => true,
      notPicked: () {
        state = const ImagePickingState.error();
        return false;
      },
      error: () {
        state = const ImagePickingState.error();
        return false;
      },
    );
  }
}

enum PickerUse { signup, banner, gallery }
final imagePickerProvier = StateNotifierProvider.family
    .autoDispose<ImagePickingNotifier, ImagePickingState, PickerUse>(
  (ref, _) {
    return ImagePickingNotifier();
  },
);

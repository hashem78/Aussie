import 'dart:io';
import 'dart:typed_data';

import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/util/asize.dart';
import 'package:aussie/util/jpeg_decoder.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

part 'single_image_picking_state.dart';

class SingleImagePickingCubit extends Cubit<SingleImagePickingState> {
  SingleImagePickingCubit() : super(const SingleImagePickingInitial());
  Future<void> pickImage({
    int? maxWidth,
    int? maxHeight,
    required CropStyle cropStyle,
    CropAspectRatio? aspectRatio,
    int quality = 60,
  }) async {
    try {
      final List<Asset> assets = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
      );
      final ByteData data = await assets.first.getByteData(quality: quality);
      final Directory docDir = await getApplicationDocumentsDirectory();
      final String docPath = docDir.path;
      final ByteBuffer buffer = data.buffer;

      final File file = File("$docPath/singUpImage.jpeg")
        ..writeAsBytesSync(
          buffer.asUint8List(
            data.offsetInBytes,
            data.lengthInBytes,
          ),
        );
      final File? croppedImage = await ImageCropper.cropImage(
        sourcePath: file.path,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        cropStyle: cropStyle,
        aspectRatio: aspectRatio,
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blue,
          hideBottomControls: true,
        ),
      );

      if (croppedImage != null) {
        final JpegDecoder decoder = JpegDecoder(croppedImage.readAsBytesSync());
        final ASize? size = decoder.size;
        emit(
          SingleImagePickingDone(
            data: AussieByteData(
              byteData: ByteData.view(croppedImage.readAsBytesSync().buffer),
              height: size?.height ?? maxHeight,
              width: size?.width ?? maxWidth,
            ),
            path: croppedImage.path,
          ),
        );
      }
    } on Exception {
      emit(const SingleImagePickingError());
    }
  }

  AussieByteData? get value {
    final SingleImagePickingState _currentState = state;
    if (_currentState is SingleImagePickingDone) {
      return _currentState.data;
    } else {
      return null;
    }
  }

  void emitInitial() {
    emit(const SingleImagePickingInitial());
  }
}

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

part 'multi_image_picking_state.dart';

class MultiImagePickingCubit extends Cubit<MultiImagePickingState> {
  MultiImagePickingCubit() : super(MultiImagePickingInitial());

  Future<void> pickImages() async {
    try {
      emit(MultiImageMultiPickingLoading());

      final List<Asset> assets =
          await MultiImagePicker.pickImages(maxImages: 10);

      final List<AussieByteData> data = [];
      final Directory dir = await getApplicationDocumentsDirectory();
      for (final element in assets) {
        final String filePath = "${dir.path}/${element.name}.jpeg";
        final ByteData byteData = await element.getByteData(quality: 80);
        File(filePath).writeAsBytesSync(
          byteData.buffer.asUint8List(
            byteData.offsetInBytes,
            byteData.lengthInBytes,
          ),
        );
        final File? croppedFile = await ImageCropper.cropImage(
          sourcePath: filePath,
          aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
          maxHeight: 1444,
          androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            hideBottomControls: true,
          ),
        );
        if (croppedFile != null) {
          final Uint8List bytes = croppedFile.readAsBytesSync();
          final JpegDecoder decoder = JpegDecoder(bytes);
          final ASize size = decoder.size!;
          data.add(
            AussieByteData(
              byteData: ByteData.view(bytes.buffer),
              height: size.height,
              width: size.width,
            ),
          );
        }
        emit(MultiImagePickingDone(data));
      }
    } on Exception catch (e) {
      if (e is PlatformException) {
        if (e.code == "Exif error") {}
      } else if (e is NoImagesSelectedException) {
        emit(MultiImagePickingError());
      }
    }
  }

  List<AussieByteData>? get values {
    final MultiImagePickingState _currentState = state;

    if (_currentState is MultiImagePickingDone) {
      return _currentState.assets;
    } else {
      return null;
    }
  }

  void emitInitial() {
    emit(MultiImagePickingInitial());
  }
}

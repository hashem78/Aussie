import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'multi_image_picking_state.dart';

class MultiImagePickingCubit extends Cubit<MultiImagePickingState> {
  MultiImagePickingCubit() : super(MultiImagePickingInitial());

  Future<void> pickImages() async {
    emit(MultiImageMultiPickingLoading());

    final Future<List<Asset>> assets =
        MultiImagePicker.pickImages(maxImages: 10);

    final List<Future<ByteData>> data = [];

    assets.then(
      (value) {
        for (final element in value) {
          data.add(element.getByteData(quality: 60));
        }
      },
    ).then(
      (_) {
        Future.wait(data).then(
          (value) {
            emit(MultiImagePickingDone(value));
          },
        );
      },
      onError: (Object e, StackTrace stackTrace) {
        if (e is PlatformException) {
          if (e.code == "Exif error") {}
        } else if (e is NoImagesSelectedException) {
          emit(MultiImagePickingError());
        }
      },
    );
  }

  List<ByteData> get values {
    final _currentState = state;

    if (_currentState is MultiImagePickingDone) {
      return _currentState.assets;
    } else {
      return null;
    }
  }
}

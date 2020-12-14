import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'image_picking_state.dart';

class ImagePickingCubit extends Cubit<ImagePickingState> {
  ImagePickingCubit() : super(ImagePickingInitial());

  Future<void> pickImages() async {
    emit(ImagePickingLoading());
    try {
      List<Asset> assets = await MultiImagePicker.pickImages(maxImages: 10);

      List<ByteData> data = [];
      assets.forEach(
        (element) async {
          data.add(await element.getByteData(quality: 60));
        },
      );

      emit(ImagePickingMultiDone(data));
    } catch (e) {
      emit(ImagePickingMultiError());
    }
  }

  Future<void> pickImage() async {
    emit(ImagePickingLoading());
    try {
      List<Asset> assets = await MultiImagePicker.pickImages(maxImages: 1);
      ByteData data = await assets.first.getByteData(quality: 60);

      emit(ImagePickingSingleDone(data));
    } catch (e) {
      emit(ImagePickingSingleError());
    }
  }

  List<ByteData> get values {
    final _currentState = state;
    if (_currentState is ImagePickingMultiDone) {
      return _currentState.assets;
    } else
      return null;
  }

  ByteData get value {
    final _currentState = state;
    if (_currentState is ImagePickingSingleDone) {
      return _currentState.data;
    } else
      return null;
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'single_image_picking_state.dart';

class SingleImagePickingCubit extends Cubit<SingleImagePickingState> {
  SingleImagePickingCubit() : super(SingleImagePickingInitial());
  Future<void> pickImage() async {
    emit(SingleImagePickingLoading());

    final Future<List<Asset>> assets =
        MultiImagePicker.pickImages(maxImages: 1);
    final Future<ByteData> data =
        assets.then((value) => value.first.getByteData(quality: 60));
    data
        .then(
          (value) => emit(SingleImagePickingDone(value)),
        )
        .catchError((error) => emit(SingleImagePickingError()));
  }

  ByteData get value {
    final _currentState = state;
    if (_currentState is SingleImagePickingDone) {
      return _currentState.data;
    } else {
      return null;
    }
  }
}

import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'image_picking_state.freezed.dart';

class ImageWithAttributes {
  final String path;
  final int width;
  final int height;
  final Uint8List byteData;

  ImageWithAttributes({
    required this.path,
    required this.width,
    required this.height,
    required this.byteData,
  });
}

@freezed
class ImagePickingState with _$ImagePickingState {
  const factory ImagePickingState.picked(
    List<ImageWithAttributes> images,
  ) = _ImagePickingStatePicked;
  const factory ImagePickingState.notPicked() = _ImagePickingStateNotPicked;
  const factory ImagePickingState.error() = _ImagePickingStateError;
}

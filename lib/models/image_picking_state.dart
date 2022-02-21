import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'image_picking_state.freezed.dart';

@freezed
class ImagePickingState with _$ImagePickingState {
  const factory ImagePickingState.picked(
    List<String> paths,
    List<Uint8List> byteData,
  ) = _ImagePickingStatePicked;
  const factory ImagePickingState.notPicked() = _ImagePickingStateNotPicked;
}

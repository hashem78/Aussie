part of 'image_picking_cubit.dart';

abstract class ImagePickingState extends Equatable {
  const ImagePickingState();

  @override
  List<Object> get props => [];
}

class ImagePickingInitial extends ImagePickingState {}

class ImagePickingMultiError extends ImagePickingState {}

class ImagePickingSingleError extends ImagePickingState {}

class ImagePickingLoading extends ImagePickingState {}

class ImagePickingMultiDone extends ImagePickingState {
  final List<ByteData> assets;

  ImagePickingMultiDone(this.assets);
  @override
  List<Object> get props => [assets];
}

class ImagePickingSingleDone extends ImagePickingState {
  final ByteData data;

  ImagePickingSingleDone(this.data);
  @override
  List<Object> get props => [data];
}

part of 'single_image_picking_cubit.dart';

abstract class SingleImagePickingState extends Equatable {
  const SingleImagePickingState();

  @override
  List<Object> get props => [];
}

class SingleImagePickingInitial extends SingleImagePickingState {}

class SingleImagePickingDone extends SingleImagePickingState {
  final AussieByteData data;
  final Image image;
  final String path;

  const SingleImagePickingDone({
    this.data,
    this.image,
    this.path,
  });
  @override
  List<Object> get props => [
        data,
        image,
        path,
      ];
}

class SingleImagePickingError extends SingleImagePickingState {
  const SingleImagePickingError();
}

class SingleImagePickingLoading extends SingleImagePickingState {
  const SingleImagePickingLoading();
}

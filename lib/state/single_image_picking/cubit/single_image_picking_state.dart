part of 'single_image_picking_cubit.dart';

abstract class SingleImagePickingState extends Equatable {
  const SingleImagePickingState();

  @override
  List<Object> get props => [];
}

class SingleImagePickingInitial extends SingleImagePickingState {}

class SingleImagePickingDone extends SingleImagePickingState {
  final ByteData data;

  const SingleImagePickingDone(this.data);
  @override
  List<Object> get props => [data];
}

class SingleImagePickingError extends SingleImagePickingState {}

class SingleImagePickingLoading extends SingleImagePickingState {}

part of 'multi_image_picking_cubit.dart';

abstract class MultiImagePickingState extends Equatable {
  const MultiImagePickingState();

  @override
  List<Object> get props => [];
}

class MultiImagePickingInitial extends MultiImagePickingState {}

class MultiImagePickingError extends MultiImagePickingState {}

class MultiImageMultiPickingLoading extends MultiImagePickingState {}

class MultiImagePickingDone extends MultiImagePickingState {
  final List<AussieByteData> assets;

  const MultiImagePickingDone(this.assets);
  @override
  List<Object> get props => [assets];
}

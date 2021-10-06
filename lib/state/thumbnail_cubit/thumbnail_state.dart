part of 'thumbnail_cubit.dart';

@immutable
abstract class ThumbnailState extends Equatable {
  const ThumbnailState();

  @override
  List<Object> get props => <Object>[];
}

class ThumbnailInitial extends ThumbnailState {}

class ThumbnailLoading extends ThumbnailState {}

class ThumbnailLoaded extends ThumbnailState {
  final List<String> imageUrls;
  const ThumbnailLoaded({
    required this.imageUrls,
  });
  @override
  List<Object> get props => <Object>[imageUrls];
}

class ThumbnailsUnavailable extends ThumbnailState {}

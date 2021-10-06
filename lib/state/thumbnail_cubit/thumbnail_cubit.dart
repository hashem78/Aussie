import 'package:aussie/repositories/thumbnail_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'thumbnail_state.dart';

class ThumbnailCubit extends Cubit<ThumbnailState> {
  ThumbnailCubit(this.route)
      : _proivder = ThumbnailRepository(route: route),
        super(ThumbnailInitial());
  final String route;
  final ThumbnailRepository _proivder;

  Future<void> fetch() async {
    emit(ThumbnailLoading());
    final List<String> _internalList = await _proivder.fetch();
    if (_internalList.isEmpty) {
      emit(ThumbnailsUnavailable());
    } else {
      emit(ThumbnailLoaded(imageUrls: _internalList));
    }
  }
}

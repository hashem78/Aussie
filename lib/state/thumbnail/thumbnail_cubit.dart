import 'package:Aussie/repositories/thumbnail/thumbnail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'thumbnail_state.dart';

class ThumbnailCubit extends Cubit<ThumbnailState> {
  ThumbnailCubit(route)
      : route = route,
        _proivder = ThumbnailOnlineRepository(route: route),
        super(ThumbnailInitial());
  final String route;
  final ThumbnailOnlineRepository _proivder;

  Future<void> fetch() async {
    emit(ThumbnailLoading());
    var _internalList = await _proivder.fetch();
    emit(ThumbnailLoaded(imageUrls: _internalList));
  }
}

import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/repositories/efe/efe.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'efe_state.dart';

typedef S ItemCreator<S>(Map<String, dynamic> map);

class EFECubit<T extends MainScreenDetailsModel> extends Cubit<EFEState> {
  EFECubit(
    String route,
    this.creator,
  )   : assert(route != null && creator != null),
        _repository = OnlineEFERepository<T>(
          route,
          creator,
        ),
        super(EFEInitial());
  ItemCreator<T> creator;
  OnlineEFERepository<T> _repository;
  void fetch() {
    emit(EFELoading());
    _repository.fetch().then((value) {
      emit(EFEDataChanged(value));
    });
  }
}

import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/repositories/efe/efe.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'efe_state.dart';

class EFECubit<T extends EFEModel> extends Cubit<EFEState> {
  EFECubit(String route)
      : assert(route != null),
        _repository = OnlineEFERepository<T>(route),
        super(EFEInitial());
  OnlineEFERepository<T> _repository;
  void fetch() {
    emit(EFELoading());
    _repository.fetch().then((value) {
      emit(EFEDataChanged(value));
    });
  }
}

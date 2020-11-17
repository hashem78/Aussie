import 'package:aussie/models/dyk/dyk.dart';

import 'package:aussie/repositories/dyk/dyk.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'dyk_state.dart';

class DykCubit extends Cubit<DykState> {
  DykCubit() : super(DykInitial());
  DYKRepository _repository = DYKRepository();
  void fetch() {
    emit(DykLoading());
    _repository.fetch().then((value) => emit(DykLoaded(value)));
  }
}

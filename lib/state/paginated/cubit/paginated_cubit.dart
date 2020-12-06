import 'dart:collection';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/repositories/searchable.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paginated_state.dart';

class PaginatedCubit<T extends IPaginatedData> extends Cubit<PaginatedState> {
  PaginatedCubit(String repositoryRoute)
      : repositoy = PaginatedRepositoy(route: repositoryRoute),
        super(PaginatedInitial());
  final PaginatedRepositoy<T> repositoy;
  void filter(String filterFor, String searchValue) async {
    try {
      var models = await repositoy.filter(filterFor, searchValue);
      emit(PaginatedFiltered(UnmodifiableListView(models)));
    } on NoSuchMethodError {
      emit(PaginatedFiltered(UnmodifiableListView([])));
    }
  }

  Future<void> loadMoreAsync({int page, int amount}) async {
    var _avail = await repositoy.fetch(page, fetchAmount: amount);
    if (_avail.length == 0) {
      emit(
        PaginatedEnd(UnmodifiableListView([])),
      );
      return;
    }
    if (amount > _avail.length) {
      amount = _avail.length;
    }

    emit(PaginatedDataChanged(UnmodifiableListView(_avail)));
  }
}

import 'dart:collection';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/repositories/paginated_searchable_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paginated_state.dart';

class PaginatedCubit<T extends IPaginatedData> extends Cubit<PaginatedState> {
  PaginatedCubit(String repositoryRoute)
      : repositoy = PaginatedRepositoy(route: repositoryRoute),
        super(const PaginatedInitial());
  final PaginatedRepositoy<T> repositoy;
  Future<void> filter(String filterFor, String searchValue) async {
    try {
      final models = await repositoy.filter(filterFor, searchValue);
      emit(PaginatedFiltered(UnmodifiableListView(models)));
    } catch (e) {
      emit(PaginatedFiltered(UnmodifiableListView([])));
    }
  }

  Future<void> loadMoreAsync({int page, int amount}) async {
    final _avail = await repositoy.fetch(page, fetchAmount: amount);
    if (_avail.isEmpty) {
      emit(
        PaginatedEnd(UnmodifiableListView([])),
      );
      return;
    }

    emit(PaginatedDataChanged(UnmodifiableListView(_avail)));
  }
}

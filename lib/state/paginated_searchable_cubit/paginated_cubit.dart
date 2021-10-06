import 'dart:collection';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/repositories/paginated_searchable_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paginated_state.dart';

class PaginatedCubit<T extends IPaginatedData> extends Cubit<PaginatedState> {
  PaginatedCubit(String repositoryRoute)
      : repositoy = PaginatedRepositoy<T>(
          route: repositoryRoute,
        ),
        super(const PaginatedInitial());
  final PaginatedRepositoy<T> repositoy;
  Future<void> filter(
      String filterFor, String searchValue, String language) async {
    try {
      final List<IPaginatedData> models = await repositoy.filter(
        language,
        filterFor,
        searchValue,
      );
      emit(
        PaginatedFiltered(
          UnmodifiableListView<IPaginatedData>(models),
        ),
      );
    } catch (e) {
      emit(
        PaginatedFiltered(
          UnmodifiableListView<IPaginatedData>(<IPaginatedData>[]),
        ),
      );
    }
  }

  Future<void> loadMoreAsync(
    String language, {
    required int page,
    required int amount,
  }) async {
    final List<IPaginatedData> _avail = await repositoy.fetch(
      language,
      page,
      fetchAmount: amount,
    );
    if (_avail.isEmpty) {
      emit(
        PaginatedEnd(UnmodifiableListView<IPaginatedData>(<IPaginatedData>[])),
      );
      return;
    }

    emit(PaginatedDataChanged(UnmodifiableListView<IPaginatedData>(_avail)));
  }

  void emitInital() {
    emit(const PaginatedInitial());
  }
}

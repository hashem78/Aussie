import 'dart:collection';

import 'package:aussie/interfaces/paginated_data_model.dart';
import 'package:aussie/repositories/paginated/online.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aussiepaginated_state.dart';

class AussiePaginatedCubit<T extends PaginatedDataModel>
    extends Cubit<AussiePaginatedState> {
  AussiePaginatedCubit(String repositoryRoute)
      : repositoy = PaginatedOnlineRepositoy(route: repositoryRoute),
        super(AussiePaginatedInitial());
  final PaginatedOnlineRepositoy<T> repositoy;
  void filter(String filterFor, String searchValue) async {
    try {
      var models = await repositoy.filter(filterFor, searchValue);
      emit(AussiePaginatedFiltered(models: UnmodifiableListView(models)));
    } on NoSuchMethodError {
      emit(AussiePaginatedFiltered(models: UnmodifiableListView([])));
    }
  }

  Future<void> loadMoreAsync({int page, int amount}) async {
    var _avail = await repositoy.fetch(page, fetchAmount: amount);
    if (_avail.length == 0) {
      emit(
        AussiePaginatedEnd(
          text: "rip",
          models: UnmodifiableListView([]),
        ),
      );
      return;
    }
    if (amount > _avail.length) {
      amount = _avail.length;
    }

    emit(AussiePaginatedDataChanged(models: UnmodifiableListView(_avail)));
  }
}

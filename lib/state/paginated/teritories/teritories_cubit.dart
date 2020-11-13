import 'dart:collection';

import 'package:aussie/interfaces/cubit/paginated_screen.dart';
import 'package:aussie/interfaces/paginated_data_model.dart';
import 'package:aussie/repositories/paginated/online.dart';

import '../../../models/paginated/teritories/teritory.dart';

import '../common/paginated_screen_state.dart';

class TeritoriesCubit extends PaginatedScreenCubit {
  TeritoriesCubit() : super(PaginatedScreenInitial());

  PaginatedOnlineRepositoy<TeritoryModel> repositoy = PaginatedOnlineRepositoy(
    route: "teritories",
  );

  void filter(String searchValue) {
    List<TeritoryModel> models = currentData
        .where((element) => (element as TeritoryModel).title == searchValue)
        .toList();
    emit(PaginatedScreenFiltered(models: UnmodifiableListView(models)));
  }

  void returnToCurrent() {
    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(currentData)));
  }

  Future<void> loadMoreAsync({int page, int amount}) async {
    var _avail = await repositoy.fetch(page, fetchAmount: amount);
    if (_avail.length == 0) {
      emit(
        PaginatedScreenEnd(
          text: "rip",
          models: UnmodifiableListView([]),
        ),
      );
      return;
    }
    if (amount > _avail.length) {
      amount = _avail.length;
    }

    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(_avail)));
  }

  @override
  List<PaginatedDataModel> currentData = [];
}

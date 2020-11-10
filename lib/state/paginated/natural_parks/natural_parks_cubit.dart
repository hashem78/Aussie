import 'dart:collection';

import 'package:Aussie/interfaces/cubit/paginated_screen.dart';
import 'package:Aussie/interfaces/paginated_data_model.dart';
import 'package:Aussie/repositories/paginated/online.dart';

import '../common/paginated_screen_state.dart';
import '../../../models/paginated/natural_parks/natural_parks.dart';

class NaturalParksCubit extends PaginatedScreenCubit {
  NaturalParksCubit() : super(PaginatedScreenInitial());
  PaginatedOnlineRepositoy<NaturalParkModel> repositoy =
      PaginatedOnlineRepositoy(
    route: "naturalParks",
  );

  void filter(String searchValue) {
    List<NaturalParkModel> models = currentData
        .where(
            (element) => (element as NaturalParkModel).parkName == searchValue)
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

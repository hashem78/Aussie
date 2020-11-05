import 'dart:collection';

import 'package:Aussie/interfaces/cubit/paginated_screen.dart';
import 'package:Aussie/interfaces/paginated_data_model.dart';

import '../common/paginated_screen_state.dart';
import '../../../models/paginated/natural_parks/natural_parks.dart';
import 'package:flutter/material.dart';

class NaturalParksCubit extends PaginatedScreenCubit {
  NaturalParksCubit() : super(PaginatedScreenInitial());

  Queue<NaturalParkModel> totalData = Queue.from(
    List.generate(
      20,
      (_) => NaturalParkModel(
        title: UniqueKey().toString(),
        longitude: "1",
        latitude: "1",
        summary: "kkkk",
        sections: [{}],
      ),
    ),
  );

  void filter(String searchValue) {
    List<NaturalParkModel> models = currentData
        .where((element) => (element as NaturalParkModel).title == searchValue)
        .toList();
    emit(PaginatedScreenFiltered(models: UnmodifiableListView(models)));
  }

  void returnToCurrent() {
    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(currentData)));
  }

  int get _avail => totalData.length;
  Future<void> loadMoreAsync(int amount) async {
    if (_avail == 0) {
      emit(
        PaginatedScreenEnd(
          text: "rip",
          models: UnmodifiableListView(currentData),
        ),
      );
      return;
    }
    if (amount > _avail) {
      amount = _avail;
    }
    List<NaturalParkModel> models = [...currentData];
    for (int i = 0; i < amount; ++i) models.add(totalData.removeLast());

    currentData = models;
    await Future.delayed(Duration(seconds: 2));

    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(models)));
  }

  @override
  List<PaginatedDataModel> currentData = [];
}

import 'dart:collection';

import 'package:Aussie/interfaces/cubit/paginated_screen.dart';
import 'package:Aussie/interfaces/paginated_data_model.dart';

import '../../../models/paginated/teritories/teritory.dart';

import 'package:flutter/material.dart';
import '../common/paginated_screen_state.dart';

class TeritoriesCubit extends PaginatedScreenCubit {
  TeritoriesCubit() : super(PaginatedScreenInitial());

  Queue<TeritoryModel> totalData = Queue.from(
    List.generate(
      20,
      (_) => TeritoryModel(
        admin: "1",
        longitude: 151.205475,
        latitude: -33.861481,
        title: UniqueKey().toString(),
      ),
    ),
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
    List<TeritoryModel> models = [...currentData];
    for (int i = 0; i < amount; ++i) models.add(totalData.removeLast());

    currentData = models;
    await Future.delayed(Duration(seconds: 2));

    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(models)));
  }

  @override
  List<PaginatedDataModel> currentData = [];
}

import 'dart:collection';

import 'package:aussie/constants.dart';
import 'package:aussie/interfaces/cubit/paginated_screen.dart';
import 'package:aussie/interfaces/paginated_data_model.dart';

import '../../../models/paginated/species/species.dart';
import 'package:flutter/material.dart';

import '../common/paginated_screen_state.dart';

class FaunaCubit extends PaginatedScreenCubit {
  FaunaCubit() : super(PaginatedScreenInitial());

  Queue<SpeciesDetailsModel> totalData = Queue.from(List.generate(
    20,
    (_) => SpeciesDetailsModel(
      description: klorem,
      scientificName: UniqueKey().toString(),
      commonName: "Lol",
      type: "kek",
      titleImageUrl: kurl,
    ),
  ));

  void filter(String searchValue) {
    List<PaginatedDataModel> models = currentData
        .where(
          (element) =>
              (element as SpeciesDetailsModel).commonName == searchValue,
        )
        .toList();
    emit(PaginatedScreenFiltered(models: UnmodifiableListView(models)));
  }

  void returnToCurrent() {
    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(currentData)));
  }

  int get _avail => totalData.length;
  Future<void> loadMoreAsync({int page, int amount}) async {
    print("avail in fauna: $_avail");
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
    List<SpeciesDetailsModel> models = [...currentData];
    for (int i = 0; i < amount; ++i) models.add(totalData.removeLast());

    currentData = models;
    await Future.delayed(Duration(seconds: 2));

    emit(PaginatedScreenDataChanged(models: UnmodifiableListView(models)));
  }

  @override
  List<PaginatedDataModel> currentData = [];
}

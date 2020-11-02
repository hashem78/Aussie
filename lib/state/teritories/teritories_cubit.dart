import 'dart:collection';

import 'package:Aussie/models/teritories/teritory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'teritories_state.dart';

class TeritoriesCubit extends Cubit<TeritoriesState> {
  TeritoriesCubit() : super(TeritoriesInitial());

  static int _loaded = 0;
  static List<TeritoryModel> totalData = List.generate(
    50,
    (_) => TeritoryModel(
      admin: "1",
      longitude: 151.205475,
      latitude: -33.861481,
      title: UniqueKey().toString(),
    ),
  );
  static List<TeritoryModel> _currentData = [];

  void filter(String searchValue) {
    List<TeritoryModel> models =
        _currentData.where((element) => element.title == searchValue).toList();
    emit(TeritoriesFiltered(models: UnmodifiableListView(models)));
  }

  void returnToCurrent() {
    emit(TeritoriesDataChanged(models: UnmodifiableListView(_currentData)));
  }

  int get _avail => totalData.length - _loaded;
  Future<void> loadMoreAsync(int amount) async {
    if (_avail == 0) {
      emit(
        TeritoriesEnd(
          text: "rip",
          models: UnmodifiableListView(_currentData),
        ),
      );
      return;
    }
    if (amount > _avail) {
      amount = _avail;
    }
    List<TeritoryModel> models = [..._currentData];
    for (int k = 1; k <= amount; ++k)
      models.add(
        TeritoryModel(
          admin: "2",
          longitude: 151.205475,
          latitude: -33.861481,
          title: "Melbourne2",
        ),
      );
    _loaded += amount;
    _currentData = models;
    await Future.delayed(Duration(seconds: 2));

    emit(TeritoriesDataChanged(models: UnmodifiableListView(models)));
  }
}

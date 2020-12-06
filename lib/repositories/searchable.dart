import 'dart:collection';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/models/info/natural_parks.dart';
import 'package:aussie/models/info/species.dart';
import 'package:aussie/models/info/teritory.dart';

import 'package:aussie/providers/searchable.dart';

import 'package:flutter/foundation.dart';

@immutable
class PaginatedRepositoy<T extends IPaginatedData> {
  final PaginatedOnlineDataProvider _onlineDataProvider;
  PaginatedRepositoy({
    String route,
  }) : _onlineDataProvider = PaginatedOnlineDataProvider(route);
  Future<List<IPaginatedData>> fetch(int page, {int fetchAmount}) async {
    assert(fetchAmount != null, "Fetch Amount is null");
    Map<String, dynamic> _repResponse;

    _repResponse =
        await _onlineDataProvider.fetch(page, fetchAmount: fetchAmount);

    return UnmodifiableListView(_toData(_repResponse));
  }

  Future<List<IPaginatedData>> filter(String field, String value) async {
    assert(field != null && value != null);
    Map<String, dynamic> _repResponse;

    _repResponse = await _onlineDataProvider.filter(field, value);
    return UnmodifiableListView(_toData(_repResponse));
  }

  List<IPaginatedData> _toData(Map<String, dynamic> response) {
    if (response.containsKey('error')) {
      throw ("${response['error']}");
    } else {
      List<IPaginatedData> _q = [];
      if (T == NaturalParkModel) {
        response.entries.forEach((element) {
          _q.add(NaturalParkModel.fromJson(element.value));
        });
      } else if (T == TeritoryModel) {
        response.entries.forEach((element) {
          _q.add(TeritoryModel.fromJson(element.value));
        });
      } else if (T == SpeciesDetailsModel) {
        response.entries.forEach((element) {
          _q.add(SpeciesDetailsModel.fromJson(element.value));
        });
      }
      return _q;
    }
  }
}
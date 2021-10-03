import 'dart:collection';

import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/models/info/natural_parks/natural_parks_model.dart';
import 'package:aussie/models/info/species/species_model.dart';
import 'package:aussie/models/info/teritory/teritory.dart';
import 'package:aussie/providers/paginated_searchable_provider.dart';
import 'package:flutter/foundation.dart';

@immutable
class PaginatedRepositoy<T extends IPaginatedData> {
  final PaginatedOnlineDataProvider _onlineDataProvider;
  PaginatedRepositoy({
    required String route,
  }) : _onlineDataProvider = PaginatedOnlineDataProvider(route);
  Future<List<IPaginatedData>> fetch(String language, int page,
      {required int fetchAmount}) async {
    Map<String, dynamic> _repResponse;

    _repResponse = await _onlineDataProvider.fetch(language, page,
        fetchAmount: fetchAmount);

    return UnmodifiableListView(_toData(_repResponse));
  }

  Future<List<IPaginatedData>> filter(
      String language, String field, String value) async {
    Map<String, dynamic> _repResponse;

    _repResponse = await _onlineDataProvider.filter(language, field, value);
    return UnmodifiableListView(_toData(_repResponse));
  }

  List<IPaginatedData> _toData(Map<String, dynamic> response) {
    if (response.containsKey('error')) {
      throw response['error'] as Object;
    } else {
      final List<IPaginatedData> _q = [];
      if (T == NaturalParkModel) {
        for (var element in response.entries) {
          _q.add(
            NaturalParkModel.fromJson(element.value as Map<String, dynamic>),
          );
        }
      } else if (T == TeritoryModel) {
        for (var element in response.entries) {
          _q.add(
            TeritoryModel.fromJson(element.value as Map<String, dynamic>),
          );
        }
      } else if (T == SpeciesDetailsModel) {
        for (var element in response.entries) {
          _q.add(
            SpeciesDetailsModel.fromJson(
              element.value as Map<String, dynamic>,
            ),
          );
        }
      }
      return _q;
    }
  }
}

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
    @required String route,
  }) : _onlineDataProvider = PaginatedOnlineDataProvider(route);
  Future<List<IPaginatedData>> fetch(String language, int page,
      {@required int fetchAmount}) async {
    assert(fetchAmount != null, "Fetch Amount is null");
    Map<String, dynamic> _repResponse;

    _repResponse = await _onlineDataProvider.fetch(language, page,
        fetchAmount: fetchAmount);

    return UnmodifiableListView(_toData(_repResponse));
  }

  Future<List<IPaginatedData>> filter(
      String language, String field, String value) async {
    assert(field != null && value != null);
    Map<String, dynamic> _repResponse;

    _repResponse = await _onlineDataProvider.filter(language, field, value);
    return UnmodifiableListView(_toData(_repResponse));
  }

  List<IPaginatedData> _toData(Map<String, dynamic> response) {
    if (response.containsKey('error')) {
      throw response['error'];
    } else {
      final List<IPaginatedData> _q = [];
      if (T == NaturalParkModel) {
        response.entries.forEach((element) {
          _q.add(
            NaturalParkModel.fromJson(element.value as Map<String, dynamic>),
          );
        });
      } else if (T == TeritoryModel) {
        response.entries.forEach((element) {
          _q.add(
            TeritoryModel.fromJson(element.value as Map<String, dynamic>),
          );
        });
      } else if (T == SpeciesDetailsModel) {
        response.entries.forEach((element) {
          _q.add(
            SpeciesDetailsModel.fromJson(
              element.value as Map<String, dynamic>,
            ),
          );
        });
      }
      return _q;
    }
  }
}
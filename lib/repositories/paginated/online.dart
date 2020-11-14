import 'dart:collection';

import 'package:aussie/interfaces/paginated_data_model.dart';
import 'package:aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:aussie/models/paginated/species/species.dart';
import 'package:aussie/models/paginated/teritories/teritory.dart';
import 'package:aussie/providers/online/paginated/online.dart';
import 'package:aussie/repositories/paginated/repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class PaginatedOnlineRepositoy<T extends PaginatedDataModel>
    implements PaginatedRepository {
  final PaginatedOnlineDataProvider _onlineDataProvider;
  PaginatedOnlineRepositoy({
    String route,
  }) : _onlineDataProvider = PaginatedOnlineDataProvider(route);
  @override
  Future<List<PaginatedDataModel>> fetch(int page, {int fetchAmount}) async {
    assert(fetchAmount != null, "Fetch Amount is null");
    Map<String, dynamic> _repResponse;

    _repResponse =
        await _onlineDataProvider.fetch(page, fetchAmount: fetchAmount);

    return UnmodifiableListView(_toData(_repResponse));
  }

  Future<List<PaginatedDataModel>> filter(String field, String value) async {
    assert(field != null && value != null);
    Map<String, dynamic> _repResponse;

    _repResponse = await _onlineDataProvider.filter(field, value);
    return UnmodifiableListView(_toData(_repResponse));
  }

  List<PaginatedDataModel> _toData(Map<String, dynamic> response) {
    if (response.containsKey('error')) {
      throw ("${response['error']}");
    } else {
      List<PaginatedDataModel> _q = [];
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

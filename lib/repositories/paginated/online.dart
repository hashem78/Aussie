import 'package:Aussie/interfaces/paginated_data_model.dart';
import 'package:Aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:Aussie/models/paginated/species/species.dart';
import 'package:Aussie/models/paginated/teritories/teritory.dart';
import 'package:Aussie/providers/online/paginated/online.dart';
import 'package:Aussie/repositories/paginated/repository.dart';
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

    if (_repResponse.containsKey('error')) {
      throw ("${_repResponse['error']}");
    } else {
      List<PaginatedDataModel> _q = [];
      if (T == NaturalParkModel) {
        _repResponse.entries.forEach((element) {
          _q.add(NaturalParkModel.fromJson(element.value));
        });
      } else if (T == TeritoryModel) {
        _repResponse.entries.forEach((element) {
          _q.add(TeritoryModel.fromJson(element.value));
        });
      } else if (T == SpeciesDetailsModel) {
        _repResponse.entries.forEach((element) {
          _q.add(SpeciesDetailsModel.fromJson(element.value));
        });
      }
      return _q;
    }
  }
}

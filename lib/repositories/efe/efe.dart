import 'dart:collection';

import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/models/efe/entertainment/details.dart';
import 'package:aussie/models/efe/explore/events/details.dart';
import 'package:aussie/providers/online/efe/efe.dart';

class OnlineEFERepository<T extends EFEModel> {
  OnlineEFERepository(String route)
      : _efeOnlineDataProvider = EFEOnlineDataProvider(route);
  EFEOnlineDataProvider _efeOnlineDataProvider;
  Future<List<EFEModel>> fetch() async {
    var _fetched = await _efeOnlineDataProvider.fetch();

    List<EFEModel> _internalList = [];
    _fetched.forEach(
      (element) {
        if (T == EntertainmentDetailsModel) {
          var _model = EntertainmentDetailsModel.fromMap(element);
          print("model in repository: $_model");
          _internalList.add(_model);
        } else if (T == EventDetailsModel) {
          var _model = EventDetailsModel.fromMap(element);
          print("model in repository: $_model");
          _internalList.add(_model);
        }
      },
    );

    return UnmodifiableListView(_internalList);
  }
}

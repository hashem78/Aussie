import 'dart:collection';

import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/providers/online/efe/efe.dart';

typedef S ItemCreator<S>(Map<String, dynamic> map);

class OnlineEFERepository<T extends EFEModel> {
  OnlineEFERepository(String route, this.creator)
      : assert(creator != null),
        _efeOnlineDataProvider = EFEOnlineDataProvider(route);
  EFEOnlineDataProvider _efeOnlineDataProvider;
  ItemCreator<T> creator;
  Future<List<EFEModel>> fetch() async {
    var _fetched = await _efeOnlineDataProvider.fetch();
    List<EFEModel> _internalList = [];
    _fetched.forEach((element) => _internalList.add(creator(element)));
    return UnmodifiableListView(_internalList);
  }
}

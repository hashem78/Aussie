import 'dart:collection';

import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/providers/online/efe/efe.dart';

typedef S ItemCreator<S>(Map<String, dynamic> map);

class OnlineEFERepository<T extends MainScreenDetailsModel> {
  OnlineEFERepository(String route, this.creator)
      : assert(creator != null),
        _efeOnlineDataProvider = EFEOnlineDataProvider(route);
  EFEOnlineDataProvider _efeOnlineDataProvider;
  ItemCreator<T> creator;
  Future<List<MainScreenDetailsModel>> fetch() async {
    var _fetched = await _efeOnlineDataProvider.fetch();
    List<MainScreenDetailsModel> _internalList = [];
    _fetched.forEach((element) => _internalList.add(creator(element)));
    return UnmodifiableListView(_internalList);
  }

  Future<List<MainScreenDetailsModel>> loadMore(int page) async {
    var _fetched = await _efeOnlineDataProvider.loadMore(page);
    List<MainScreenDetailsModel> _internalList = [];
    _fetched.forEach((element) => _internalList.add(creator(element)));
    return UnmodifiableListView(_internalList);
  }
}

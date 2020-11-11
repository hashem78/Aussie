import 'dart:collection';

import 'package:Aussie/providers/online/thumbnail/thumbnail.dart';

class ThumbnailOnlineRepository {
  final ThumbnailOnlineProivder _repo;
  ThumbnailOnlineRepository({
    String route,
  }) : _repo = ThumbnailOnlineProivder(route: route);
  Future<List<String>> fetch() async {
    List<String> _internalList = await _repo.fetch();
    return UnmodifiableListView(_internalList);
  }
}

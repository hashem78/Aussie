import 'dart:collection';

import 'package:aussie/providers/thumbnail.dart';

class ThumbnailRepository {
  final ThumbnailOnlineProivder _repo;
  ThumbnailRepository({
    String route,
  }) : _repo = ThumbnailOnlineProivder(route: route);
  Future<List<String>> fetch() async {
    List<String> _internalList = await _repo.fetch();
    return UnmodifiableListView(_internalList);
  }
}

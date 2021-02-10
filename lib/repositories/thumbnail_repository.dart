import 'dart:collection';

import 'package:aussie/providers/thumbnail_provider.dart';

class ThumbnailRepository {
  final ThumbnailOnlineProivder _repo;
  ThumbnailRepository({
    String route,
  }) : _repo = ThumbnailOnlineProivder(route: route);
  Future<List<String>> fetch() async {
    final List<String> _internalList = await _repo.fetch();
    return UnmodifiableListView(_internalList);
  }
}

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class EFEOnlineDataProvider {
  final String route;
  EFEOnlineDataProvider(this.route);
  Future<List<Map<String, dynamic>>> fetch() async {
    final _docs = await FirebaseFirestore.instance
        .collection(route)
        .where("featured", isEqualTo: true)
        .get();
    final List<Map<String, dynamic>> _internalList = [];
    for (final _doc in _docs.docs) {
      final _data = _doc.data();
      _internalList.add(_data);
    }
    return UnmodifiableListView(_internalList);
  }

  Future<List<Map<String, dynamic>>> loadMore(int page) async {
    final _docs = await FirebaseFirestore.instance
        .collection(route)
        .where(
          "idx",
          isGreaterThanOrEqualTo: page,
          isLessThan: page + 10,
        )
        .get();

    final List<Map<String, dynamic>> _internalList = [];
    for (final _doc in _docs.docs) {
      final _data = _doc.data();
      _internalList.add(_data);
    }
    return UnmodifiableListView(_internalList);
  }
}

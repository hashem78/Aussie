import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class EFEOnlineDataProvider {
  final String route;
  EFEOnlineDataProvider(this.route);
  Future<List<Map<String, dynamic>>> fetch() async {
    var _docs = await FirebaseFirestore.instance.collection(route).get();
    List<Map<String, dynamic>> _internalList = [];
    for (var _doc in _docs.docs) {
      var _data = _doc.data();
      _internalList.add(_data);
    }
    return UnmodifiableListView(_internalList);
  }
}

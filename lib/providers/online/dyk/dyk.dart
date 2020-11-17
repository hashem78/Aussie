import 'package:cloud_firestore/cloud_firestore.dart';

class DYKOnlineProvider {
  Future<List<String>> fetch() async {
    var _collection =
        await FirebaseFirestore.instance.collection("dyk_facts").get();
    var _docs = _collection.docs;
    List<String> _internalList = [];
    for (var doc in _docs) {
      var _data = doc.data();
      _internalList.add(_data["text"]);
    }
    return _internalList;
  }
}

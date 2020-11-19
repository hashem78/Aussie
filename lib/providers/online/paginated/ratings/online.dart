import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class PaginatedOnlineRatingsProvider {
  final String docId;
  PaginatedOnlineRatingsProvider(this.docId) : assert(docId != null);
  Future<List<Map<String, dynamic>>> fetch(
    int page, {
    int fetchAmount,
  }) async {
    var _reviewsCollection = await FirebaseFirestore.instance
        .collection("movies/$docId/reviews")
        .where(
          "index",
          isGreaterThanOrEqualTo: page,
          isLessThan: page + fetchAmount,
        )
        .get();
    var _reviewDocs = _reviewsCollection.docs;
    List<Map<String, dynamic>> _internalList = [];
    for (var doc in _reviewDocs) {
      if (doc.id != "current_index") {
        var _data = doc.data();
        _internalList.add(_data);
      }
    }
    return UnmodifiableListView(_internalList);
  }

  Future<List<Map<String, dynamic>>> getSpecificAmount(int fetchAmount) async {
    var _reviewsCollection = await FirebaseFirestore.instance
        .collection("movies/$docId/reviews")
        .limit(3)
        .get();
    var _reviewDocs = _reviewsCollection.docs;
    List<Map<String, dynamic>> _internalList = [];
    for (var doc in _reviewDocs) {
      if (doc.id != "current_index") {
        var _data = doc.data();
        _internalList.add(_data);
      }
    }
    return UnmodifiableListView(_internalList);
  }

  Future<void> addRating(Map<String, dynamic> rating) async {
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        var _reviewsCollection =
            FirebaseFirestore.instance.collection("movies/$docId/reviews");

        var _currentIndex = await transaction.get(
          _reviewsCollection.doc("current_index"),
        );
        Map<String, dynamic> _internalMap = {};
        _internalMap.addAll(rating);
        _internalMap["index"] = _currentIndex.data()["index"] + 1;
        transaction.update(
          _reviewsCollection.doc("current_index"),
          {"index": _currentIndex.data()["index"] + 1},
        );

        await _reviewsCollection.add(_internalMap);
      },
    );
  }
}

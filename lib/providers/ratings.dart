import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class PaginatedOnlineRatingsProvider {
  final String docId;
  final String route;
  PaginatedOnlineRatingsProvider(this.route, this.docId)
      : assert(
          docId != null,
          route != null,
        );
  Future<List<Map<String, dynamic>>> fetch(
    int page, {
    int fetchAmount,
  }) async {
    final _reviewsCollection = await FirebaseFirestore.instance
        .collection("$route/$docId/reviews")
        .where(
          "index",
          isGreaterThanOrEqualTo: page,
          isLessThan: page + fetchAmount,
        )
        .get();
    final _reviewDocs = _reviewsCollection.docs;
    final List<Map<String, dynamic>> _internalList = [];
    for (final doc in _reviewDocs) {
      if (doc.id != "current_index") {
        final _data = doc.data();
        _internalList.add(_data);
      }
    }
    return UnmodifiableListView(_internalList);
  }

  Future<List<Map<String, dynamic>>> getSpecificAmount(int fetchAmount) async {
    final _reviewsCollection = await FirebaseFirestore.instance
        .collection("$route/$docId/reviews")
        .limit(3)
        .get();
    final _reviewDocs = _reviewsCollection.docs;
    final List<Map<String, dynamic>> _internalList = [];
    for (final doc in _reviewDocs) {
      if (doc.id != "current_index") {
        final _data = doc.data();
        _internalList.add(_data);
      }
    }
    return UnmodifiableListView(_internalList);
  }

  Future<void> addRating(Map<String, dynamic> rating) async {
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        final _reviewsCollection =
            FirebaseFirestore.instance.collection("$route/$docId/reviews");

        final _currentIndex = await transaction.get(
          _reviewsCollection.doc("current_index"),
        );
        final Map<String, dynamic> _internalMap = {};
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

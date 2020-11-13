import 'dart:collection';

import 'package:aussie/providers/online/paginated/data.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

@immutable
class PaginatedOnlineDataProvider implements PaginatedDataProvider {
  final String route; // Api route for online and box name for local

  const PaginatedOnlineDataProvider(this.route);
  @override
  Future<Map<String, dynamic>> fetch(int page, {int fetchAmount = 10}) async {
    var _internalMap = Map<String, dynamic>();

    var queries = await FirebaseFirestore.instance
        .collection(route)
        .orderBy('idx')
        .where(
          'idx',
          isGreaterThanOrEqualTo: page,
          isLessThan: page + fetchAmount,
        )
        .get();

    queries.docs.forEach((element) {
      var mp = element.data();
      _internalMap[mp['idx'].toString()] = mp;
    });
    return UnmodifiableMapView(_internalMap);
  }
}

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class PaginatedOnlineDataProvider {
  final String route; // Api route for online and box name for local

  const PaginatedOnlineDataProvider(this.route);
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

  Future<Map<String, dynamic>> filter(String field, String value) async {
    var _internalMap = Map<String, dynamic>();

    //  var _split = filed.s
    String searchQuery = "";
    if (field.length > 1) {
      List<String> _split = value.split(' ');
      searchQuery = _split
          .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
          .toList()
          .reduce((value, element) => '$value $element');
    } else {
      searchQuery = searchQuery.toUpperCase();
    }
    var queries = await FirebaseFirestore.instance
        .collection(route)
        .where(
          field,
          isGreaterThanOrEqualTo: searchQuery,
        )
        .get();

    queries.docs.forEach((element) {
      var mp = element.data();
      _internalMap[mp['idx'].toString()] = mp;
    });
    return UnmodifiableMapView(_internalMap);
  }
}

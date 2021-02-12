import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class PaginatedOnlineDataProvider {
  final String route; // Api route for online and box name for local

  const PaginatedOnlineDataProvider(this.route);
  Future<Map<String, dynamic>> fetch(String language, int page,
      {int fetchAmount = 10}) async {
    final _internalMap = <String, dynamic>{};

    final queries = await FirebaseFirestore.instance
        .collection('${route}_$language')
        .orderBy('idx')
        .where(
          'idx',
          isGreaterThanOrEqualTo: page,
          isLessThan: page + fetchAmount,
        )
        .get();

    queries.docs.forEach((element) {
      final mp = element.data();
      _internalMap[mp['idx'].toString()] = mp;
    });
    return UnmodifiableMapView(_internalMap);
  }

  Future<Map<String, dynamic>> filter(
      String language, String field, String value) async {
    final _internalMap = <String, dynamic>{};

    //  final _split = filed.s
    String searchQuery = "";
    if (field.length > 1) {
      final List<String> _split = value.split(' ');
      searchQuery = _split
          .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
          .toList()
          .reduce((value, element) => '$value $element');
    } else {
      searchQuery = searchQuery.toUpperCase();
    }
    final queries = await FirebaseFirestore.instance
        .collection('${route}_$language')
        .where(
          field,
          isGreaterThanOrEqualTo: searchQuery,
        )
        .get();

    queries.docs.forEach((element) {
      final mp = element.data();
      _internalMap[mp['idx'].toString()] = mp;
    });
    return UnmodifiableMapView(_internalMap);
  }
}

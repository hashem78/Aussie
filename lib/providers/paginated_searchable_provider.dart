import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class PaginatedOnlineDataProvider {
  final String route; // Api route for online and box name for local

  const PaginatedOnlineDataProvider(this.route);
  Future<Map<String, dynamic>> fetch(
    String language,
    int page, {
    int fetchAmount = 10,
  }) async {
    final Map<String, dynamic> _internalMap = <String, dynamic>{};

    final QuerySnapshot<Map<String, dynamic>> queries =
        await FirebaseFirestore.instance
            .collection('${route}_$language')
            .orderBy('idx')
            .where(
              'idx',
              isGreaterThanOrEqualTo: page,
              isLessThan: page + fetchAmount,
            )
            .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> element
        in queries.docs) {
      final Map<String, dynamic> mp = element.data();
      _internalMap[mp['idx'].toString()] = mp;
    }
    return UnmodifiableMapView<String, dynamic>(_internalMap);
  }

  Future<Map<String, dynamic>> filter(
    String language,
    String field,
    String value,
  ) async {
    final Map<String, dynamic> _internalMap = <String, dynamic>{};

    //  final _split = filed.s
    String searchQuery = '';
    if (field.length > 1) {
      final List<String> _split = value.split(' ');
      searchQuery = _split
          .map((String e) => '${e[0].toUpperCase()}${e.substring(1)}')
          .toList()
          .reduce((String value, String element) => '$value $element');
    } else {
      searchQuery = searchQuery.toUpperCase();
    }
    final QuerySnapshot<Map<String, dynamic>> queries =
        await FirebaseFirestore.instance
            .collection('${route}_$language')
            .where(
              field,
              isGreaterThanOrEqualTo: searchQuery,
            )
            .get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> element
        in queries.docs) {
      final Map<String, dynamic> mp = element.data();
      _internalMap[mp['idx'].toString()] = mp;
    }
    return UnmodifiableMapView<String, dynamic>(_internalMap);
  }
}

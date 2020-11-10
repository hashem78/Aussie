import 'dart:collection';

import 'package:Aussie/providers/paginated/data.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

@immutable
class PaginatedOnlineDataProvider implements PaginatedDataProvider {
  final String route; // Api route for online and box name for local

  const PaginatedOnlineDataProvider(this.route);
  @override
  Future<Map<String, dynamic>> fetch(int page, {int fetchAmount = 10}) async {
    var _internalMap = Map<String, dynamic>();
    if (!await _isInternetAvailable) {
      return _failedInternetConnectionResponse;
    } else {
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

  Map<String, Object> get _failedInternetConnectionResponse => {
        "error":
            "Internet connection unavailble, please make sure you're on a stable network and try again later.",
      };

  Future<bool> get _isInternetAvailable async {
    final bool _avail = await DataConnectionChecker().hasConnection;
    print("Internet is available: $_avail");
    return _avail;
  }
}

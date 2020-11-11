import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ThumbnailOnlineProivder {
  final String route;
  ThumbnailOnlineProivder({
    @required this.route,
  });

  Future<List<String>> fetch() async {
    var _list = await FirebaseFirestore.instance.collection(route).get();
    var _internalList = <String>[];
    _list.docs.forEach((element) {
      _internalList.add(element.data()["image_link"]);
    });
    _internalList.shuffle();
    return UnmodifiableListView(List<String>.from(_internalList));
  }
}

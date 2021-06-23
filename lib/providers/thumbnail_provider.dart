import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class ThumbnailOnlineProivder {
  final String? route;
  ThumbnailOnlineProivder({
    required this.route,
  });

  Future<List<String>> fetch() async {
    final _list = await FirebaseFirestore.instance.collection(route!).get();
    final _internalList = <String?>[];
    _list.docs.forEach(
      (element) => _internalList.add(element.data()["image_link"] as String?),
    );
    _internalList.shuffle();
    return UnmodifiableListView(List<String>.from(_internalList));
  }
}

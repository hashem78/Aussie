import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class ThumbnailOnlineProivder {
  final String? route;
  ThumbnailOnlineProivder({
    required this.route,
  });

  Future<List<String>> fetch() async {
    final QuerySnapshot<Map<String, dynamic>> _list =
        await FirebaseFirestore.instance.collection(route!).get();
    final List<String?> _internalList = <String?>[];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> element
        in _list.docs) {
      _internalList.add(element.data()['image_link'] as String?);
    }
    _internalList.shuffle();
    return UnmodifiableListView<String>(List<String>.from(_internalList));
  }
}

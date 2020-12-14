import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class EventManagementProvider {
  static final _storage = FirebaseStorage.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  Future<EventManagementNotification> addEvent(EventCreationModel model) async {
    try {
      final String uid = _auth.currentUser.uid;

      final String path = "users/$uid/events/${model.uuid}";

      _firestore.collection("global_events").doc().set(
        {
          "eventOwner": uid,
          "eventUuid": model.uuid,
        },
      );

      _firestore.doc(path).set(
        {
          "startingTimeStamp": model.startingTimeStamp,
          "endingTimeStamp": model.endingTimeStamp,
          "description": model.description,
          "uuid": model.uuid,
          "lat": model.lat,
          "lng": model.lng,
          "title": model.title,
          "subtitle": model.subtitle,
          "galleryImageLinks": [],
          "bannerImageLink": "",
          "eventAttendees": []
        },
      );

      var _ref = _storage.ref().child("$path/galleryImageLinks");

      final updateGalleryLinksCallback =
          (String value) => _firestore.doc(path).update(
                {
                  "galleryImageLinks": FieldValue.arrayUnion([value])
                },
              );

      final dlGalleryCallback = (ByteData element) {
        if (element == null) return;
        final _gUploadTask = _ref.putData(element.buffer.asUint8List());

        _gUploadTask.whenComplete(
          () => _ref.getDownloadURL().then(updateGalleryLinksCallback),
        );
      };

      final updateBannerLinkCallback =
          (String value) => _firestore.doc(path).update(
                {"bannerImageLink": value},
              );

      final dlBannerCallback = (ByteData element) {
        if (element == null) return;
        final _gUploadTask = _ref.putData(element.buffer.asUint8List());

        _gUploadTask.whenComplete(
          () => _ref.getDownloadURL().then(updateBannerLinkCallback),
        );
      };

      model.imageData.forEach(dlGalleryCallback);
      dlBannerCallback(model.bannerData);
    } catch (e) {
      print(e);
      return EventManagementErrorNotification();
    }
    return EventManagementSuccessNotification();
  }
}

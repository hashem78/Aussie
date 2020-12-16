import 'dart:collection';

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
      _firestore.collection("users").doc(uid).update(
        {
          "numberOfPosts": FieldValue.increment(1),
        },
      );

      await _firestore.doc(path).set(
        {
          "uid": uid,
          "startingTimeStamp": model.startingTimeStamp,
          "endingTimeStamp": model.endingTimeStamp,
          "description": model.description,
          "address": model.address,
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

      final updateGalleryLinksCallback = (String value) {
        return _firestore.doc(path).update(
          {
            "galleryImageLinks": FieldValue.arrayUnion([value])
          },
        );
      };

      final dlGalleryCallback = (ByteData element) {
        if (element == null) return;

        final _refG = _storage.ref().child("$path/galleryImageLinks");

        final _gUploadTask = _refG.putData(element.buffer.asUint8List());
        _gUploadTask.whenComplete(
          () => _refG.getDownloadURL().then(updateGalleryLinksCallback),
        );
      };

      final updateBannerLinkCallback = (String value) {
        return _firestore.doc(path).update(
          {"bannerImageLink": value},
        );
      };

      final dlBannerCallback = (ByteData element) {
        if (element == null) return;
        final _refB = _storage.ref().child(path);
        final _bUploadTask = _refB.putData(element.buffer.asUint8List());

        _bUploadTask.whenComplete(
          () => _refB.getDownloadURL().then(updateBannerLinkCallback),
        );
      };

      for (var data in model.imageData) {
        dlGalleryCallback(data);
      }
      dlBannerCallback(model.bannerData);
    } on FirebaseAuthException {
      return EventManagementErrorNotification();
    } on FirebaseException {
      return EventManagementErrorNotification();
    }
    return EventManagementSuccessNotification();
  }

  Future<EventManagementNotification> fetchEvents(
    DocumentSnapshot documentSnapshot,
  ) async {
    try {
      if (_auth.currentUser != null) {
        String uid = _auth.currentUser.uid;
        if (documentSnapshot != null) {
          var _data = await _firestore
              .collection("users/$uid/events")
              .orderBy("uuid")
              .startAfterDocument(documentSnapshot)
              .limit(6)
              .get();
          var _docs = _data.docs;

          List<Map<String, dynamic>> _internalList = [];
          _docs.forEach(
            (element) {
              if (_docs.last.id != "~INDEX") _internalList.add(element.data());
            },
          );

          return EventModelsContainingNotification(
            eventModels: UnmodifiableListView(_internalList),
            prevsnap: _docs.last,
          );
        } else {
          var _data = await _firestore
              .collection("users/$uid/events")
              .orderBy("uuid")
              .limit(5)
              .get();
          var _docs = _data.docs;

          List<Map<String, dynamic>> _internalList = [];
          _docs.forEach(
            (element) {
              if (_docs.last.id != "~INDEX") _internalList.add(element.data());
            },
          );
          if (_docs.length < 5)
            return EventModelsContainingEndNotification(_internalList);

          return EventModelsContainingNotification(
            eventModels: UnmodifiableListView(_internalList),
            prevsnap: _docs.last,
          );
        }
      }
      return EventModelsContainingNotification();
    } catch (e) {
      return EventManagementErrorNotification();
    }
  }
}

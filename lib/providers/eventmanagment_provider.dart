import 'dart:collection';

import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class EventManagementProvider {
  static final _storage = FirebaseStorage.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  Future<EventManagementNotification> addEvent(EventCreationModel model) async {
    try {
      final String uid = _auth.currentUser!.uid;

      final String path = "users/$uid/events/${model.eventId}";
      final WriteBatch batch = _firestore.batch();
      batch.update(
        _firestore.collection("users").doc(uid),
        {
          "numberOfPosts": FieldValue.increment(1),
        },
      );

      batch.set(
        _firestore.doc(path),
        {
          "uid": uid,
          "eventId": model.eventId,
          "startingTimeStamp": model.startingTimeStamp,
          "endingTimeStamp": model.endingTimeStamp,
          "description": model.description,
          "address": model.address,
          "lat": model.lat,
          "lng": model.lng,
          "title": model.title,
          "subtitle": model.subtitle,
          "galleryImages": [],
          "bannerImage": {},
          "created": FieldValue.serverTimestamp(),
        },
      );
      final updateGalleryLinksCallback =
          (String value, AussieByteData byteData) {
        return batch.update(_firestore.doc(path), {
          "galleryImages": FieldValue.arrayUnion([
            {
              "imageLink": value,
              "height": byteData.height,
              "width": byteData.width,
            }
          ])
        });
      };

      final dlGalleryCallback = (AussieByteData element) async {
        final _refG = _storage.ref(path).child(const Uuid().v4());

        final _gUploadTask = await _refG.putData(
          element.byteData!.buffer.asUint8List(),
        );
        final downloadUrl = await _gUploadTask.ref.getDownloadURL();
        updateGalleryLinksCallback(downloadUrl, element);
      };

      final updateBannerLinkCallback = (String link, AussieByteData byteData) {
        return batch.update(
          _firestore.doc(path),
          {
            "bannerImage": {
              "imageLink": link,
              "height": byteData.height,
              "width": byteData.width,
            }
          },
        );
      };

      final dlBannerCallback = (AussieByteData? element) async {
        if (element == null) return;
        final _refB = _storage.ref(path).child(const Uuid().v4());
        final _bUploadTask = await _refB.putData(
          element.byteData!.buffer.asUint8List(),
        );
        final downloadUrl = await _bUploadTask.ref.getDownloadURL();
        updateBannerLinkCallback(downloadUrl, element);
      };
      for (final data in model.imageData!) {
        await dlGalleryCallback(data);
      }
      await dlBannerCallback(model.bannerData);
      batch.commit();
    } on FirebaseAuthException {
      return const ErrorNotification();
    } on FirebaseException {
      return const ErrorNotification();
    }
    return const SuccessNotification();
  }

  Future<EventManagementNotification> fetchUserEvents(
    DocumentSnapshot? documentSnapshot,
  ) async {
    try {
      if (_auth.currentUser != null) {
        final String uid = _auth.currentUser!.uid;
        if (documentSnapshot != null) {
          final _data = await _firestore
              .collection("users/$uid/events")
              .orderBy("eventId")
              .startAfterDocument(documentSnapshot)
              .limit(10)
              .get();
          final _docs = _data.docs;

          final List<Map<String, dynamic>> _internalList = [];
          _docs.forEach(
            (element) {
              _internalList.add(element.data());
            },
          );
          if (_docs.length < 10) {
            return EventsEndNotification(_internalList);
          }
          return EventModelsNotification(
            eventModels: UnmodifiableListView(_internalList),
            prevsnap: _docs.last,
          );
        } else {
          final _data = await _firestore
              .collection("users/$uid/events")
              .orderBy("eventId")
              .limit(10)
              .get();
          final _docs = _data.docs;

          final List<Map<String, dynamic>> _internalList = [];
          _docs.forEach(
            (element) {
              _internalList.add(element.data());
            },
          );
          if (_docs.length < 10) {
            return EventsEndNotification(_internalList);
          }

          return EventModelsNotification(
            eventModels: UnmodifiableListView(_internalList),
            prevsnap: _docs.last,
          );
        }
      }
      return const EventModelsNotification();
    } catch (e) {
      return const ErrorNotification();
    }
  }

  Future<EventManagementNotification> fetchPublicEvents(
    DocumentSnapshot? documentSnapshot,
  ) async {
    try {
      if (documentSnapshot != null) {
        final _data = await _firestore
            .collectionGroup("events")
            .startAfterDocument(documentSnapshot)
            .limit(10)
            .get();
        final _docs = _data.docs;

        final List<Map<String, dynamic>> _internalList = [];
        _docs.forEach(
          (element) {
            _internalList.add(element.data());
          },
        );
        if (_docs.length < 10) {
          return EventsEndNotification(_internalList);
        }
        return EventModelsNotification(
          eventModels: UnmodifiableListView(_internalList),
          prevsnap: _docs.last,
        );
      } else {
        final _data =
            await _firestore.collectionGroup("events").limit(10).get();
        final _docs = _data.docs;

        final List<Map<String, dynamic>> _internalList = [];
        _docs.forEach(
          (element) {
            _internalList.add(element.data());
          },
        );

        if (_docs.length < 10) {
          return EventsEndNotification(_internalList);
        }

        return EventModelsNotification(
          eventModels: UnmodifiableListView(_internalList),
          prevsnap: _docs.last,
        );
      }
    } catch (e) {
      return const ErrorNotification();
    }
  }
}

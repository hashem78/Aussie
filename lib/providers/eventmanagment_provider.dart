import 'dart:collection';

import 'package:aussie/interfaces/eventmanagement_notifs.dart';
import 'package:aussie/models/usermanagement/events/eventcreation_model.dart';
import 'package:aussie/models/usermanagement/events/eventmanagement_notifs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class EventManagementProvider {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<EventManagementNotification> addEvent(EventCreationModel model) async {
    try {
      final String uid = _auth.currentUser!.uid;

      final String path = 'users/$uid/events/${model.eventId}';
      final WriteBatch batch = _firestore.batch();
      batch.update(
        _firestore.collection('users').doc(uid),
        <String, dynamic>{
          'numberOfPosts': FieldValue.increment(1),
        },
      );

      batch.set(
        _firestore.doc(path),
        <String, dynamic>{
          'uid': uid,
          'eventId': model.eventId,
          'startingTimeStamp': model.startingTimeStamp,
          'endingTimeStamp': model.endingTimeStamp,
          'description': model.description,
          'address': model.address,
          'lat': model.lat,
          'lng': model.lng,
          'title': model.title,
          'subtitle': model.subtitle,
          'galleryImages': <Map<String, dynamic>>[],
          'bannerImage': <String, dynamic>{},
          'created': FieldValue.serverTimestamp(),
        },
      );
      updateGalleryLinksCallback(String value, AussieByteData byteData) {
        return batch.update(
          _firestore.doc(path),
          <String, dynamic>{
            'galleryImages': FieldValue.arrayUnion(
              <Map<String, dynamic>>[
                <String, dynamic>{
                  'imageLink': value,
                  'height': byteData.height,
                  'width': byteData.width,
                }
              ],
            )
          },
        );
      }

      dlGalleryCallback(AussieByteData element) async {
        final Reference _refG = _storage.ref(path).child(const Uuid().v4());

        final TaskSnapshot _gUploadTask = await _refG.putData(
          element.byteData!.buffer.asUint8List(),
        );
        final String downloadUrl = await _gUploadTask.ref.getDownloadURL();
        updateGalleryLinksCallback(downloadUrl, element);
      }

      updateBannerLinkCallback(String link, AussieByteData byteData) {
        return batch.update(
          _firestore.doc(path),
          <String, Map<String, dynamic>>{
            'bannerImage': <String, dynamic>{
              'imageLink': link,
              'height': byteData.height,
              'width': byteData.width,
            }
          },
        );
      }

      dlBannerCallback(AussieByteData? element) async {
        if (element == null) return;
        final Reference _refB = _storage.ref(path).child(const Uuid().v4());
        final TaskSnapshot _bUploadTask = await _refB.putData(
          element.byteData!.buffer.asUint8List(),
        );
        final String downloadUrl = await _bUploadTask.ref.getDownloadURL();
        updateBannerLinkCallback(downloadUrl, element);
      }

      for (final AussieByteData data in model.imageData!) {
        await dlGalleryCallback(data);
      }
      await dlBannerCallback(model.bannerData);
      batch.commit();
    } catch (e, st) {
      print(e);
      print(st);
    }
    return const SuccessNotification();
  }

  Future<EventManagementNotification> fetchEventsForUser(
    String uid,
    DocumentSnapshot<Object?>? documentSnapshot,
  ) async {
    try {
      if (documentSnapshot == null) {
        final QuerySnapshot<Map<String, dynamic>> _data = await _firestore
            .collection('users/$uid/events')
            .orderBy('eventId')
            .limit(10)
            .get();
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs =
            _data.docs;

        final List<Map<String, dynamic>> _internalList =
            <Map<String, dynamic>>[];
        for (QueryDocumentSnapshot<Map<String, dynamic>> element in _docs) {
          _internalList.add(element.data());
        }
        if (_docs.length < 10) {
          return EventsEndNotification(_internalList);
        }

        return EventModelsNotification(
          eventModels: UnmodifiableListView<Map<String, dynamic>>(
            _internalList,
          ),
          prevsnap: _docs.last,
        );
      } else {
        final QuerySnapshot<Map<String, dynamic>> _data = await _firestore
            .collection('users/$uid/events')
            .orderBy('eventId')
            .startAfterDocument(documentSnapshot)
            .limit(10)
            .get();
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs =
            _data.docs;

        final List<Map<String, dynamic>> _internalList =
            <Map<String, dynamic>>[];
        for (QueryDocumentSnapshot<Map<String, dynamic>> element in _docs) {
          _internalList.add(element.data());
        }
        if (_docs.length < 10) {
          return EventsEndNotification(_internalList);
        }
        return EventModelsNotification(
          eventModels:
              UnmodifiableListView<Map<String, dynamic>>(_internalList),
          prevsnap: _docs.last,
        );
      }
    } catch (e) {
      return const ErrorNotification();
    }
  }

  Future<EventManagementNotification> fetchPublicEvents(
    DocumentSnapshot<Object?>? documentSnapshot,
  ) async {
    try {
      if (documentSnapshot != null) {
        final QuerySnapshot<Map<String, dynamic>> _data = await _firestore
            .collectionGroup('events')
            .startAfterDocument(documentSnapshot)
            .limit(10)
            .get();
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs =
            _data.docs;

        final List<Map<String, dynamic>> _internalList =
            <Map<String, dynamic>>[];
        for (QueryDocumentSnapshot<Map<String, dynamic>> element in _docs) {
          _internalList.add(element.data());
        }
        if (_docs.length < 10) {
          return EventsEndNotification(_internalList);
        }
        return EventModelsNotification(
          eventModels: UnmodifiableListView<Map<String, dynamic>>(
            _internalList,
          ),
          prevsnap: _docs.last,
        );
      } else {
        final QuerySnapshot<Map<String, dynamic>> _data =
            await _firestore.collectionGroup('events').limit(10).get();
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs =
            _data.docs;

        final List<Map<String, dynamic>> _internalList =
            <Map<String, dynamic>>[];
        for (QueryDocumentSnapshot<Map<String, dynamic>> element in _docs) {
          _internalList.add(element.data());
        }

        if (_docs.length < 10) {
          return EventsEndNotification(_internalList);
        }

        return EventModelsNotification(
          eventModels: UnmodifiableListView<Map<String, dynamic>>(
            _internalList,
          ),
          prevsnap: _docs.last,
        );
      }
    } catch (e) {
      return const ErrorNotification();
    }
  }
}

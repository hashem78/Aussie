import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/event_state/event_state.dart';
import 'package:aussie/models/image_picking_state/image_picking_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class EventManagementRepository {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<EventState> addEvent(EventModel model) async {
    try {
      final String uid = model.uid;

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
          'runtimeType': 'remote',
        },
      );
      updateGalleryLinksCallback(String value, ImageWithAttributes byteData) {
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

      dlGalleryCallback(ImageWithAttributes element) async {
        final Reference _refG = _storage.ref(path).child(const Uuid().v4());

        final TaskSnapshot _gUploadTask = await _refG.putData(
          element.byteData.buffer.asUint8List(),
        );
        final String downloadUrl = await _gUploadTask.ref.getDownloadURL();
        updateGalleryLinksCallback(downloadUrl, element);
      }

      updateBannerLinkCallback(String link, ImageWithAttributes byteData) {
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

      dlBannerCallback(ImageWithAttributes? element) async {
        if (element == null) return;
        final Reference _refB = _storage.ref(path).child(const Uuid().v4());
        final TaskSnapshot _bUploadTask = await _refB.putData(
          element.byteData.buffer.asUint8List(),
        );
        final String downloadUrl = await _bUploadTask.ref.getDownloadURL();
        updateBannerLinkCallback(downloadUrl, element);
      }

      final imageData = model.mapOrNull(submition: (value) => value.imageData)!;
      final bannerData =
          model.mapOrNull(submition: (value) => value.bannerData)!;

      for (final ImageWithAttributes data in imageData) {
        await dlGalleryCallback(data);
      }
      await dlBannerCallback(bannerData);
      batch.commit();
    } on FirebaseException {
      return const EventState.error();
    }
    return const EventState.sucess();
  }

  static CollectionReference<EventModel> fetchEventsForUser(
    String uid,
  ) {
    return FirebaseFirestore.instance
        .collection('users/$uid/events')
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  static Query<EventModel> fetchPublicEvents() {
    return FirebaseFirestore.instance
        .collectionGroup('events')
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }
}

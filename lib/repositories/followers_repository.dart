import 'package:aussie/models/followers_state/followers_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowersRepository {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static Future<FollowersState> isUserFollowed(String uid) async {
    final user = FirebaseAuth.instance.currentUser;
    print('called is user followed');

    try {
      final query = await _firestoreInstance
          .collection('users')
          .doc(user!.uid)
          .collection('following')
          .doc(uid)
          .get();
      if (query.exists) {
        return const FollowersState.userIsFollowed();
      }
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
    } on Exception catch (e, st) {
      print(e);
      print(st);
    }
    return const FollowersState.userIsNotFollowed();
  }

  static Future<FollowersState> followUser(String uid) async {
    final user = FirebaseAuth.instance.currentUser!;

    try {
      final writeBatch = _firestoreInstance.batch();
      final currentLoggedInUserId = user.uid;
      final doc = await _firestoreInstance
          .doc('/users/$currentLoggedInUserId/following/$uid')
          .get();
      if (!doc.exists) {
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                currentLoggedInUserId,
              ),
          {
            'numberOfFollowing': FieldValue.increment(1),
          },
        );
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                uid,
              ),
          {
            'numberOfFollowers': FieldValue.increment(1),
          },
        );
        writeBatch.set(
          _firestoreInstance.doc(
            '/users/$currentLoggedInUserId/following/$uid',
          ),
          {'uid': uid},
        );
        writeBatch.set(
          _firestoreInstance.doc(
            '/users/$uid/followers/$currentLoggedInUserId',
          ),
          {
            'uid': currentLoggedInUserId,
          },
        );
        writeBatch.commit();
      }
      return const FollowersState.userIsFollowed();
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
    } catch (e, st) {
      print(e);
      print(st);
    }
    return const FollowersState.error();
  }

  static Future<FollowersState> unFollowUser(String uid) async {
    final user = FirebaseAuth.instance.currentUser!;

    try {
      final writeBatch = _firestoreInstance.batch();
      final currentLoggedInUserId = user.uid;
      final doc = await _firestoreInstance
          .doc('/users/$currentLoggedInUserId/following/$uid')
          .get();
      if (doc.exists) {
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                currentLoggedInUserId,
              ),
          {
            'numberOfFollowing': FieldValue.increment(-1),
          },
        );
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                uid,
              ),
          {
            'numberOfFollowers': FieldValue.increment(-1),
          },
        );
        writeBatch.delete(
          _firestoreInstance.doc(
            '/users/$currentLoggedInUserId/following/$uid',
          ),
        );
        writeBatch.delete(
          _firestoreInstance.doc(
            '/users/$uid/followers/$currentLoggedInUserId',
          ),
        );
        writeBatch.commit();
      }
      return const FollowersState.userIsNotFollowed();
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
    } catch (e, st) {
      print(e);
      print(st);
    }
    return const FollowersState.error();
  }

  static CollectionReference<String> getFollowersForUser(String uid) {
    return _firestoreInstance
        .collection('/users/$uid/followers')
        .withConverter<String>(
      fromFirestore: (snapshot, _) {
        return snapshot['uid'];
      },
      toFirestore: (uid, __) {
        return {
          'uid': uid,
        };
      },
    );
  }

  static CollectionReference<String> getFollowingForUser(String uid) {
    return _firestoreInstance
        .collection('/users/$uid/following')
        .withConverter<String>(
      fromFirestore: (snapshot, _) {
        return snapshot['uid'];
      },
      toFirestore: (uid, __) {
        return {
          'uid': uid,
        };
      },
    );
  }
}

import 'dart:collection';

import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'provider_notifications/provider_notifications.dart';

typedef FollowerUserData
    = Tuple2<UnmodifiableListView<String>, DocumentSnapshot<Object?>?>;
typedef UsersList
    = Tuple2<UnmodifiableListView<AussieUser>, DocumentSnapshot<Object?>?>;

class FollowersProvider {
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;
  Future<FollowersNotification> isUserFollowed(String uid) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return const FError('User is not logged in');
    try {
      final DocumentSnapshot<Map<String, dynamic>> query =
          await _firestoreInstance
              .collection('users')
              .doc(user.uid)
              .collection('following')
              .doc(uid)
              .get();
      if (query.exists) {
        return const FUserIsFollowed();
      }
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
      FError(e.toString());
    } catch (e, st) {
      print(e);
      print(st);
      return FError(e.toString());
    }
    return const FUserIsNotFollowed();
  }

  Future<FollowersNotification> followUser(String uid) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return const FError('User is not logged in');
    try {
      final WriteBatch writeBatch = _firestoreInstance.batch();
      final String currentLoggedInUserId = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestoreInstance
              .doc('/users/$currentLoggedInUserId/following/$uid')
              .get();
      if (!doc.exists) {
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                currentLoggedInUserId,
              ),
          <String, dynamic>{
            'numberOfFollowing': FieldValue.increment(1),
          },
        );
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                uid,
              ),
          <String, dynamic>{
            'numberOfFollowers': FieldValue.increment(1),
          },
        );
        writeBatch.set(
          _firestoreInstance.doc(
            '/users/$currentLoggedInUserId/following/$uid',
          ),
          <String, String>{'uid': uid},
        );
        writeBatch.set(
          _firestoreInstance.doc(
            '/users/$uid/followers/$currentLoggedInUserId',
          ),
          <String, String>{
            'uid': currentLoggedInUserId,
          },
        );
        writeBatch.commit();
      }
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
      FError(e.toString());
    } catch (e, st) {
      print(e);
      print(st);
      return FError(e.toString());
    }
    return const FFollowedUser();
  }

  Future<FollowersNotification> unFollowUser(String uid) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return const FError('User is not logged in');
    try {
      final WriteBatch writeBatch = _firestoreInstance.batch();
      final String currentLoggedInUserId = user.uid;
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestoreInstance
              .doc('/users/$currentLoggedInUserId/following/$uid')
              .get();
      if (doc.exists) {
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                currentLoggedInUserId,
              ),
          <String, dynamic>{
            'numberOfFollowing': FieldValue.increment(-1),
          },
        );
        writeBatch.update(
          _firestoreInstance.collection('users').doc(
                uid,
              ),
          <String, dynamic>{
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
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
      FError(e.toString());
    } catch (e, st) {
      print(e);
      print(st);
      return FError(e.toString());
    }
    return const FUnFollowedUser();
  }

  Future<UnmodifiableListView<AussieUser>> getUsers(
    List<String> users,
  ) async {
    try {
      final List<AussieUser> actualUsers = <AussieUser>[];
      print('getting $users');
      if (users.isEmpty) {
        return UnmodifiableListView<AussieUser>(const <AussieUser>[]);
      }

      final QuerySnapshot<Map<String, dynamic>> query = await _firestoreInstance
          .collection('/users')
          .limit(10)
          .where('uid', whereIn: users)
          .get();
      print('the where in query retured ${query.size} results');
      if (query.size > 0) {
        for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
            in query.docs) {
          final Map<String, dynamic> userData = doc.data();
          actualUsers.add(AussieUser.fromJson(userData));
        }
        return UnmodifiableListView<AussieUser>(actualUsers);
      } else {
        return UnmodifiableListView<AussieUser>(const <AussieUser>[]);
      }
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
      rethrow;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<FollowerUserData> getFollowersForUser(
    String uid,
    DocumentSnapshot<Object?>? documentSnapshot,
  ) async {
    final List<String> userIds = <String>[];
    try {
      if (documentSnapshot == null) {
        final QuerySnapshot<Map<String, dynamic>> query =
            await _firestoreInstance
                .collection('/users/$uid/followers')
                .limit(10)
                .get();

        if (query.size > 0) {
          for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
              in query.docs) {
            userIds.add(doc.id);
          }
          return FollowerUserData(
            UnmodifiableListView<String>(userIds),
            query.docs.last,
          );
        }
        return FollowerUserData(
          UnmodifiableListView<String>(const <String>[]),
          null,
        );
      } else {
        final QuerySnapshot<Map<String, dynamic>> query =
            await _firestoreInstance
                .collection('/users/$uid/followers')
                .startAfterDocument(documentSnapshot)
                .limit(10)
                .get();

        if (query.size > 0) {
          for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
              in query.docs) {
            userIds.add(doc.id);
          }

          return FollowerUserData(
            UnmodifiableListView<String>(userIds),
            query.docs.last,
          );
        }
        return FollowerUserData(
          UnmodifiableListView<String>(const <String>[]),
          null,
        );
      }
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
      rethrow;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  Future<FollowerUserData> getFollowingForUser(
    String uid,
    DocumentSnapshot<Object?>? documentSnapshot,
  ) async {
    final List<String> userIds = <String>[];
    try {
      if (documentSnapshot == null) {
        final QuerySnapshot<Map<String, dynamic>> query =
            await _firestoreInstance
                .collection('/users/$uid/following')
                .limit(10)
                .get();
        if (query.size > 0) {
          for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
              in query.docs) {
            userIds.add(doc.id);
          }

          return FollowerUserData(
            UnmodifiableListView<String>(userIds),
            query.docs.last,
          );
        }
        return FollowerUserData(
          UnmodifiableListView<String>(const <String>[]),
          null,
        );
      } else {
        final QuerySnapshot<Map<String, dynamic>> doc = await _firestoreInstance
            .collection('/users/$uid/following')
            .startAfterDocument(documentSnapshot)
            .limit(10)
            .get();

        if (doc.size > 0) {
          for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
              in doc.docs) {
            userIds.add(doc.id);
          }
          return FollowerUserData(
            UnmodifiableListView<String>(userIds),
            doc.docs.last,
          );
        }

        return FollowerUserData(
          UnmodifiableListView<String>(userIds),
          null,
        );
      }
    } on FirebaseAuthException catch (e, st) {
      print(e);
      print(st);
      rethrow;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}

import 'dart:collection';
import 'dart:io';

import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

@immutable
class UserManagementProvider {
  static final _authInstance = FirebaseAuth.instance;
  static final _storageInstance = FirebaseStorage.instance;
  static final _firestoreInstance = FirebaseFirestore.instance;
  Future<UserManagementNotification> signup(Map<String, dynamic> map) async {
    if (map["email"] == "") {
      return const InvalidEmailNotification();
    } else if (map["password"] == "") {
      return const WeakPasswordNotification();
    } else if (map["username"] == "" || map["fullname"] == "") {
      return const WrongNameNotification();
    } else if (map["profileImagePath"] == "") {
      return const ProfileImageRequiredNotification();
    }

    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: map["email"] as String,
        password: map["password"] as String,
      );
      final String uid = FirebaseAuth.instance.currentUser.uid;
      final String _filename = path.basename(map['profileImagePath'] as String);

      final _ref =
          _storageInstance.ref().child("users/$uid/profile/$_filename");
      final _uploadTask = _ref.putFile(File(map['profileImagePath'] as String));

      await _uploadTask.whenComplete(
        () async {
          final String _profileImageLink = await _ref.getDownloadURL();

          await _firestoreInstance.doc("users/$uid").set(
            {
              "uid": uid,
              "profilePictureLink": _profileImageLink,
              "username": map["username"],
              "profileBannerLink":
                  map["profileBannerLink"] ?? "https://picsum.photos/1200",
              "fullname": map["fullname"],
              "numberOfFollowers": 0,
              "numberOfFollowing": 0,
              "numberOfPosts": 0,
              "attends": [],
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return const UserManagementErrorNotification();
    }
    return const UserSignupSuccessfulNotification();
  }

  Future<UserManagementNotification> isSignedin() async {
    final User user = FirebaseAuth.instance.currentUser;
    if (user == null) return const UserHasNotSignedInNotification();
    return const UserSigninSuccessfulNotification();
  }

  Future<UserManagementNotification> signin(Map<String, dynamic> map) async {
    if (map["email"] == "") {
      return const InvalidEmailNotification();
    } else if (map["password"] == "") {
      return const WeakPasswordNotification();
    } else if (map["username"] == "") {
      return const WrongNameNotification();
    }

    try {
      await _authInstance.signInWithEmailAndPassword(
        email: map["email"] as String,
        password: map["password"] as String,
      );

      return const UserSigninSuccessfulNotification();
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return const UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> getUserData() async {
    try {
      final User user = FirebaseAuth.instance.currentUser;
      if (user == null) return const UserHasNotSignedInNotification();
      final _db = FirebaseFirestore.instance;
      final _shot = await _db.doc('users/${user.uid}').get();
      final _data = _shot.data();

      final _internalMap = {
        "uid": user.uid,
        "name": user.displayName,
        "email": user.email,
        "verified": user.emailVerified,
        "profilePictureLink": _data["profilePictureLink"],
        "username": _data["username"],
        "fullname": _data["fullname"],
        "profileBannerLink": _data["profileBannerLink"],
        "numberOfFollowers": _data["numberOfFollowers"],
        "numberOfFollowing": _data["numberOfFollowing"],
        "numberOfPosts": _data["numberOfPosts"],
        "attends": _data["attends"],
      };
      return UserModelContainingNotification(UnmodifiableMapView(_internalMap));
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return const UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> getUserDataFromUid(String uid) async {
    if (uid == null) return const UserManagementErrorNotification();
    try {
      final _userModel =
          await _firestoreInstance.collection("users").doc(uid).get();
      return UserModelContainingNotification(
        UnmodifiableMapView(
          _userModel.data(),
        ),
      );
    } on FirebaseException {
      return const UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> makeUserWithIdAttendEvent(
      String uid, String eventUuid) async {
    if (uid == null || eventUuid == null) {
      return const UserManagementErrorNotification();
    }
    try {
      final WriteBatch writeBatch = _firestoreInstance.batch();
      writeBatch.set(
          _firestoreInstance
              .collection("event")
              .doc(eventUuid)
              .collection("attendees")
              .doc(uid),
          {"uid": uid});
      writeBatch.update(
        _firestoreInstance.collection("users").doc(uid),
        {
          "attends": FieldValue.arrayUnion([eventUuid])
        },
      );
      writeBatch.commit();
      return UserMangementUserAttendedEventNotification();
    } on FirebaseException {
      return const UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> makeUserWithIdUnAttendEvent(
      String uid, String eventUuid) async {
    if (uid == null || eventUuid == null) {
      return const UserManagementErrorNotification();
    }
    try {
      final WriteBatch writeBatch = _firestoreInstance.batch();

      writeBatch.delete(
        _firestoreInstance
            .collection("event")
            .doc(eventUuid)
            .collection("attendees")
            .doc(uid),
      );
      writeBatch.update(
        _firestoreInstance.collection("users").doc(uid),
        {
          "attends": FieldValue.arrayRemove([eventUuid])
        },
      );
      writeBatch.commit();
      return UserMangementUserUnAttendedEventNotification();
    } on FirebaseException {
      return const UserManagementErrorNotification();
    }
  }
}

import 'dart:collection';
import 'dart:io';

import 'package:aussie/interfaces/usermanagement_notifs.dart';

import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      return InvalidEmailNotification();
    } else if (map["password"] == "") {
      return WeakPasswordNotification();
    } else if (map["username"] == "" || map["fullname"] == "") {
      return WrongNameNotification();
    } else if (map["profileImagePath"] == "")
      return ProfileImageRequiredNotification();

    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: map["email"],
        password: map["password"],
      );
      String uid = FirebaseAuth.instance.currentUser.uid;
      String _filename = path.basename(map['profileImagePath']);

      var _ref = _storageInstance.ref().child("users/$uid/profile/$_filename");
      var _uploadTask = _ref.putFile(File(map['profileImagePath']));

      await _uploadTask.whenComplete(
        () async {
          String _profileImageLink = await _ref.getDownloadURL();

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
            },
          );
        },
      );
      _firestoreInstance
          .doc("users/$uid")
          .collection("events")
          .doc("~INDEX")
          .set({});
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return UserManagementErrorNotification();
    }
    return UserSignupSuccessfulNotification();
  }

  Future<UserManagementNotification> isSignedin() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) return UserHasNotSignedInNotification();
    return UserSigninSuccessfulNotification();
  }

  Future<UserManagementNotification> signin(Map<String, dynamic> map) async {
    if (map["email"] == "") {
      return InvalidEmailNotification();
    } else if (map["password"] == "") {
      return WeakPasswordNotification();
    } else if (map["username"] == "") {
      return WrongNameNotification();
    }

    try {
      await _authInstance.signInWithEmailAndPassword(
        email: map["email"],
        password: map["password"],
      );

      return UserSigninSuccessfulNotification();
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> getUserData() async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      if (user == null) return UserHasNotSignedInNotification();
      var _db = FirebaseFirestore.instance;
      var _shot = await _db.doc('users/${user.uid}').get();
      var _data = _shot.data();

      var _internalMap = {
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
      };
      return UserModelContainingNotification(UnmodifiableMapView(_internalMap));
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> getUserDataFromUid(String uid) async {
    if (uid == null) return UserManagementErrorNotification();
    try {
      var _userModel =
          await _firestoreInstance.collection("users").doc(uid).get();
      return UserModelContainingNotification(
        UnmodifiableMapView(
          _userModel.data(),
        ),
      );
    } on FirebaseException {
      return UserManagementErrorNotification();
    }
  }
}

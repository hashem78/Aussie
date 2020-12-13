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

      String _profileImageLink;

      _uploadTask.whenComplete(
        () async {
          try {
            _profileImageLink = await _ref.getDownloadURL();
          } catch (onError) {
            return UserNotFoundNotification();
          }
          await _firestoreInstance.doc("users/$uid").set(
            {
              "uid": uid,
              "profilePictureLink": _profileImageLink,
              "username": map["username"],
              "profileBannerLink":
                  map["profileBannerLink"] ?? "https://picsum.photos/1200",
              "fullname": map["fullname"]
            },
          );
          await _firestoreInstance
              .doc("users/$uid")
              .collection("events")
              .doc("INDEX")
              .set({});
          await _firestoreInstance
              .doc("users/$uid")
              .collection("attendees")
              .doc("INDEX")
              .set({});
          await _firestoreInstance
              .doc("users/$uid")
              .collection("gallery")
              .doc("INDEX")
              .set({});
        },
      );
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return UserNotFoundNotification();
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
      return UserNotFoundNotification();
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
      };
      return UserModelContainingNotification(UnmodifiableMapView(_internalMap));
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return UserManagementErrorNotification();
    }
  }

  Future<UserManagementNotification> getUserDataFromUid(String uid) async {
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

  Future<UserManagementNotification> fetchEvents(
    DocumentSnapshot documentSnapshot,
  ) async {
    try {
      if (_authInstance.currentUser != null) {
        String uid = _authInstance.currentUser.uid;
        if (documentSnapshot != null) {
          var _data = await _firestoreInstance
              .collection("users/$uid/events")
              .startAfterDocument(documentSnapshot)
              .limit(5)
              .get();
          var _docs = _data.docs;
          List<Map<String, dynamic>> _internalList = [];
          _docs.forEach(
            (element) {
              if (element.id != "INDEX") {
                _internalList.add(element.data());
              }
            },
          );
          return EventModelsContainingNotification(
            eventModels: UnmodifiableListView(_internalList),
            prevsnap: _docs.last,
          );
        } else {
          var _data = await _firestoreInstance
              .collection("users/$uid/events")
              .where("field")
              .limit(5)
              .get();
          var _docs = _data.docs;
          List<Map<String, dynamic>> _internalList = [];
          _docs.forEach(
            (element) {
              if (element.id != "INDEX") {
                _internalList.add(element.data());
              }
            },
          );
          return EventModelsContainingNotification(
            eventModels: UnmodifiableListView(_internalList),
            prevsnap: _docs.last,
          );
        }
      }
      return UserManagementErrorNotification();
    } on FirebaseException {
      return UserManagementErrorNotification();
    }
  }
}

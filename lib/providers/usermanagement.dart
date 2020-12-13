import 'dart:collection';
import 'dart:io';

import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UserManagementProvider {
  final _authInstance = FirebaseAuth.instance;
  final _storageInstance = FirebaseStorage.instance;
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
          await FirebaseFirestore.instance.doc("users/$uid").set(
            {
              "uid": uid,
              "profilePictureLink": _profileImageLink,
              "username": map["username"],
              "profileBannerLink":
                  map["profileBannerLink"] ?? "https://picsum.photos/1200",
              "fullname": map["fullname"]
            },
          );
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
      return UserNotFoundNotification();
    }
  }
}

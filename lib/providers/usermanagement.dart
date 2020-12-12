import 'dart:io';

import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UserManagementProvider {
  final _authInstance = FirebaseAuth.instance;
  final _storageInstance = FirebaseStorage.instance;
  Future<UserManagementNotification> signup(Map<String, dynamic> map) async {
    if (map["email"] == "") {
      print("missing email");
      return InvalidEmailNotification();
    } else {
      if (map["password"] == "") WeakPasswordNotification();
    }

    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: map["email"],
        password: map["password"],
      );
      String uid = FirebaseAuth.instance.currentUser.uid;
      print("image path${map['profileImagePath']}");
      String _filename = path.basename(map['profileImagePath']);

      var _ref = _storageInstance.ref().child("users/$uid/profile/$_filename");
      var _uploadTask = _ref.putFile(File(map['profileImagePath']));

      String _profileImageLink;

      _uploadTask.whenComplete(
        () async {
          try {
            _profileImageLink = await _ref.getDownloadURL();
          } catch (onError) {
            print("Error");
          }
          print(_profileImageLink);
          await FirebaseFirestore.instance.doc("users/$uid").set(
            {
              "uid": uid,
              "profilePictureLink": _profileImageLink,
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.errorCodes[e.code];
    } catch (e) {
      print(e);
      return UserNotFoundNotification();
    }

    return UserSignupSuccessfulNotification();
  }

  Future<Map<String, dynamic>> signedin() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    var _db = FirebaseFirestore.instance;
    var _shot = await _db.doc('users/${user.uid}').get();
    var _data = _shot.data();

    var _internalMap = {
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "verified": user.emailVerified,
      "profilePictureLink": _data["profilePictureLink"] ?? "",
      "profileBanner": "",
    };
    //_internalMap.addAll(_shot.data());
    return _internalMap;
  }

  Future<UserManagementNotification> signin(Map<String, dynamic> map) async {
    if (map["email"] == "") {
      return InvalidEmailNotification();
    } else if (map["password"] == "") {
      return WeakPasswordNotification();
    }

    try {
      await _authInstance.signInWithEmailAndPassword(
        email: map["email"],
        password: map["password"],
      );

      return UserSigninSuccessfulNotification();
    } on FirebaseException catch (e) {
      return UserManagementNotification.errorCodes[e.code];
    } catch (e) {
      return UserNotFoundNotification();
    }
  }
  Future<Map<String,dynamic>> getUserData()async{
    
  }
}

import 'dart:collection';
import 'dart:io';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

@immutable
class UserManagementProvider {
  static final FirebaseAuth _authInstance = FirebaseAuth.instance;
  static final FirebaseStorage _storageInstance = FirebaseStorage.instance;
  static final FirebaseFirestore _firestoreInstance =
      FirebaseFirestore.instance;
  Future<IUMNotification?> signup(Map<String, dynamic> map) async {
    // if (await DataConnectionChecker().connectionStatus ==
    //     DataConnectionStatus.disconnected) {
    //   return const UMError();
    // }
    if (map['email'] == '') {
      return const UMInvalidEmail();
    } else if (map['password'] == '') {
      return const UMWeakPassword();
    } else if (map['username'] == '' || map['fullname'] == '') {
      return const UMWrongName();
    } else if (map['profileImagePath'] == '') {
      return const UMProfileImageRequired();
    }

    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: map['email'] as String,
        password: map['password'] as String,
      );
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      final String _filename = path.basename(map['profileImagePath'] as String);

      final Reference _ref = _storageInstance.ref().child(
            'users/$uid/profile/$_filename',
          );
      final UploadTask _uploadTask = _ref.putFile(
        File(
          map['profileImagePath'] as String,
        ),
      );

      await _uploadTask.whenComplete(
        () async {
          final String _profileImageLink = await _ref.getDownloadURL();

          await _firestoreInstance.doc('users/$uid').set(
            <String, dynamic>{
              'uid': uid,
              'profilePictureLink': _profileImageLink,
              'username': map['username'],
              'profileBannerLink':
                  map['profileBannerLink'] ?? 'https://picsum.photos/1200',
              'fullname': map['fullname'],
              'numberOfFollowers': 0,
              'numberOfFollowing': 0,
              'numberOfPosts': 0,
              'attends': <dynamic>[],
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      return firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return const UMError();
    }
    return const UMSignupSuccessful();
  }

  Future<IUMNotification> isSignedin() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return const UMNotSignedIn();
    return const UMSigninSuccessful();
  }

  Future<IUMNotification?> signin(Map<String, dynamic> map) async {
    // if (await DataConnectionChecker().connectionStatus ==
    //     DataConnectionStatus.disconnected) {
    //   return const UMError();
    // }
    if (map['email'] == '') {
      return const UMInvalidEmail();
    } else if (map['password'] == '') {
      return const UMWeakPassword();
    } else if (map['username'] == '') {
      return const UMWrongName();
    }

    try {
      await _authInstance.signInWithEmailAndPassword(
        email: map['email'] as String,
        password: map['password'] as String,
      );

      return const UMSigninSuccessful();
    } on FirebaseAuthException catch (e) {
      return firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return const UMError();
    }
  }

  Future<IUMNotification?> getUserData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return const UMNotSignedIn();
      final FirebaseFirestore _db = FirebaseFirestore.instance;
      final DocumentSnapshot<Map<String, dynamic>> _shot =
          await _db.doc('users/${user.uid}').get();
      final Map<String, dynamic> _data = _shot.data()!;

      final Map<String, dynamic> _internalMap = <String, dynamic>{
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'verified': user.emailVerified,
        'profilePictureLink': _data['profilePictureLink'],
        'username': _data['username'],
        'fullname': _data['fullname'],
        'profileBannerLink': _data['profileBannerLink'],
        'numberOfFollowers': _data['numberOfFollowers'],
        'numberOfFollowing': _data['numberOfFollowing'],
        'numberOfPosts': _data['numberOfPosts'],
        'attends': _data['attends'],
      };
      return UMModelContaining(
          UnmodifiableMapView<String, dynamic>(_internalMap));
    } on FirebaseAuthException catch (e) {
      return firebaseAuthErrorCodes[e.code];
    } catch (e) {
      return const UMError();
    }
  }

  Future<IUMNotification> getUserDataFromUid(String? uid) async {
    if (uid == null) return const UMError();
    try {
      final DocumentSnapshot<Map<String, dynamic>> _userModel =
          await _firestoreInstance.collection('users').doc(uid).get();
      return UMModelContaining(
        UnmodifiableMapView<String, dynamic>(
          _userModel.data()!,
        ),
      );
    } on FirebaseException {
      return const UMError();
    }
  }

  
}

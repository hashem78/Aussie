import 'dart:io';

import 'package:evento/models/auth_state/auth_state.dart';
import 'package:evento/models/usermanagement/signin_model/signin_model.dart';
import 'package:evento/models/usermanagement/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UMRepository {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final _storageInstance = FirebaseStorage.instance;
  static final _authInstance = FirebaseAuth.instance;
  static Future<AuthState> signup({
    String? email,
    String? password,
    String? profileImagePath,
    String? username,
    String? fullname,
  }) async {
    if (email == '' || email == null || email.isEmpty) {
      return const AuthState.invalidEmail();
    } else if (password == '' || password == null || password.isEmpty) {
      return const AuthState.weakPassword();
    } else if (username == '' || username == null || username.isEmpty) {
      return const AuthState.invalidUserName();
    } else if (fullname == '' || fullname == null || fullname.isEmpty) {
      return const AuthState.invalidUserName();
    } else if (profileImagePath == '' ||
        profileImagePath == null ||
        profileImagePath.isEmpty) {
      return const AuthState.profileImageInvalid();
    }

    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser!;

      final filename = path.basename(profileImagePath);

      final ref = _storageInstance.ref().child(
            'users/${user.uid}/profile/$filename',
          );
      await ref.putFile(File(profileImagePath));
      final _profileImageLink = await ref.getDownloadURL();

      final userData = {
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'verified': user.emailVerified,
        'profilePictureLink': _profileImageLink,
        'username': username,
        'profileBannerLink': 'https://picsum.photos/1200',
        'fullname': fullname,
        'numberOfFollowers': 0,
        'numberOfFollowing': 0,
        'numberOfPosts': 0,
        'attends': const [],
        'runtimeType': 'signedIn',
      };
      await _firestoreInstance.doc('users/${user.uid}').set(userData);

      return AuthState.goodSignup(AussieUser.fromJson(userData));
    } on FirebaseAuthException catch (e) {
      print(e);
      return firebaseAuthErrorCodes[e.code]!;
    } catch (e) {
      return const AuthState.bad();
    }
  }

  static Future<AuthState> signin(SigninModel model) async {
    if (model.email == '' || model.email.isEmpty) {
      return const AuthState.invalidEmail();
    } else if (model.password == '' || model.password.isEmpty) {
      return const AuthState.weakPassword();
    }

    try {
      await _authInstance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
    } on FirebaseAuthException catch (e) {
      return firebaseAuthErrorCodes[e.code]!;
    } catch (e) {
      return const AuthState.bad();
    }

    return const AuthState.good();
  }

  static Future<AussieUser> getUserDataFromUid(String uid) async {
    try {
      final q = await _firestoreInstance.collection('users').doc(uid).get();
      final user = q.data();
      return AussieUser.fromJson(user!);
    } on Exception {
      return const AussieUser.error();
    }
  }

  static Future<void> signout() async {
    await _authInstance.signOut();
  }
}

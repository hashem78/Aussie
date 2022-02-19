import 'dart:io';

import 'package:aussie/models/auth_state/auth_state.dart';
import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UMRepository {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final _storageInstance = FirebaseStorage.instance;
  static final _authInstance = FirebaseAuth.instance;
  static Future<AuthState> signup(SignupModel model) async {
    if (model.email == '' || model.email == null || model.email!.isEmpty) {
      return const AuthState.invalidEmail();
    } else if (model.password == '' ||
        model.password == null ||
        model.password!.isEmpty) {
      return const AuthState.weakPassword();
    } else if (model.username == '' ||
        model.username == null ||
        model.username!.isEmpty) {
      return const AuthState.invalidUserName();
    } else if (model.fullname == '' ||
        model.fullname == null ||
        model.fullname!.isEmpty) {
      return const AuthState.invalidUserName();
    } else if (model.profileImagePath == '' ||
        model.profileImagePath == null ||
        model.profileImagePath!.isEmpty) {
      return const AuthState.profileImageInvalid();
    }

    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: model.email!,
        password: model.password!,
      );

      final user = FirebaseAuth.instance.currentUser!;

      final filename = path.basename(model.profileImagePath!);

      final ref = _storageInstance.ref().child(
            'users/${user.uid}/profile/$filename',
          );
      final uploadTask = ref.putFile(File(model.profileImagePath!));
      final userData = {
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'verified': user.emailVerified,
        'profilePictureLink': '',
        'username': model.username!,
        'profileBannerLink': 'https://picsum.photos/1200',
        'fullname': model.fullname!,
        'numberOfFollowers': 0,
        'numberOfFollowing': 0,
        'numberOfPosts': 0,
        'attends': <dynamic>[],
        'runtimeType': 'signedIn',
      };
      await uploadTask.whenComplete(
        () async {
          final _profileImageLink = await ref.getDownloadURL();
          userData['profilePictureLink'] = _profileImageLink;
          await _firestoreInstance.doc('users/${user.uid}').set(userData);
        },
      );

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

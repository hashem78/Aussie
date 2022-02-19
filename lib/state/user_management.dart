import 'dart:async';
import 'package:aussie/aussie_imports.dart';
import 'package:aussie/repositories/user_management_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rv;

class LocalUserNotifier extends rv.StateNotifier<AussieUser> {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final _authInstance = FirebaseAuth.instance;

  late final StreamSubscription<User?> authSubscription;
  bool isFirstRun = true;

  LocalUserNotifier() : super(const AussieUser.firstRun()) {
    authSubscription = _authInstance.userChanges().listen(userChanges);
  }

  Future<void> userChanges(User? user) async {
    if (user != null) {
      final _shot = await _firestoreInstance.doc('users/${user.uid}').get();
      if (!_shot.exists) {
        // This is a signup event most likely so we will cancel until the creation process ends
        // Navigation will handled in the signup page.
        return;
      }
      final _data = _shot.data()!;
      state = AussieUser.fromJson(_data);
    } else {
      if (isFirstRun) {
        // ignore: prefer_const_constructors
        state = AussieUser.firstRun();
        isFirstRun = !isFirstRun;
      } else {
        state = const AussieUser.signedOut();
      }
    }
  }

  AussieUser getUserData() {
    return state;
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }
}

final localUserProvider =
    rv.StateNotifierProvider<LocalUserNotifier, AussieUser>(
  (_) {
    return LocalUserNotifier();
  },
);

final remoteUserProvider = rv.FutureProvider.family<AussieUser, String>(
  (_, uid) async {
    return await UMRepository.getUserDataFromUid(uid);
  },
);
final scopedUserProvider = rv.Provider<AussieUser>((_) {
  throw UnimplementedError();
});

import 'dart:async';
import 'package:evento/models/usermanagement/user/user_model.dart';
import 'package:evento/repositories/user_management_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalUserNotifier extends StateNotifier<AussieUser> {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final _authInstance = FirebaseAuth.instance;

  late final StreamSubscription<User?> authSubscription;
  final Ref ref;
  LocalUserNotifier(this.ref) : super(const AussieUser.loading()) {
    authSubscription = _authInstance.userChanges().listen(userChanges);
  }

  Future<void> userChanges(User? user) async {
    if (user != null) {
      final snapshot = await _firestoreInstance
          .doc('users/${user.uid}')
          .snapshots()
          .firstWhere((snapshot) => snapshot.exists);
      final _data = snapshot.data()!;
      state = AussieUser.fromJson(_data);
    } else {
      state = const AussieUser.signedOut();
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

final localUserProvider = StateNotifierProvider<LocalUserNotifier, AussieUser>(
  (ref) {
    return LocalUserNotifier(ref);
  },
);

final remoteUserProvider = FutureProvider.family<AussieUser, String>(
  (_, uid) async {
    return await UMRepository.getUserDataFromUid(uid);
  },
);
final scopedUserProvider = Provider.autoDispose<AussieUser>((_) {
  throw UnimplementedError();
});

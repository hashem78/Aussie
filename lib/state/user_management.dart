import 'dart:async';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/repositories/user_management_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSignupCompletionStreamController = StreamController<bool>();
final userSignupCompletionStreamProvider = StreamProvider<bool>(
  (ref) {
    ref.onDispose(
      () {
        userSignupCompletionStreamController.close();
      },
    );
    return userSignupCompletionStreamController.stream;
  },
);

class LocalUserNotifier extends StateNotifier<AussieUser> {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final _authInstance = FirebaseAuth.instance;

  late final StreamSubscription<User?> authSubscription;
  late final StreamSubscription<AussieUser> userSignupCompletionStream;
  bool isFirstRun = true;
  Ref ref;
  LocalUserNotifier(this.ref) : super(const AussieUser.firstRun()) {
    authSubscription = _authInstance.userChanges().listen(userChanges);
  }

  Future<void> userChanges(User? user) async {
    if (user != null) {
      final _shot = await _firestoreInstance.doc('users/${user.uid}').get();
      if (!_shot.exists) {
        // This is a signup event which hasn't finished creating the user so we will wait until
        // The signup proceedure finishes and retry again
        // Navigation will handled in the signup page.
        final stream = ref.read(userSignupCompletionStreamProvider.stream);
        final completer = Completer();
        final subscription = stream.listen(
          (finishedSignUp) {
            if (finishedSignUp) {
              completer.complete();
            }
          },
        );
        await completer.future;
        subscription.cancel();
        final _shot = await _firestoreInstance.doc('users/${user.uid}').get();
        final _data = _shot.data()!;
        state = AussieUser.fromJson(_data);
        return;
      } else {
        final _data = _shot.data()!;
        state = AussieUser.fromJson(_data);
      }
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

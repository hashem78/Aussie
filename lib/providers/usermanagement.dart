import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagementProvider {
  Future<UserManagementNotification> signup(Map<String, dynamic> map) async {
    if (map["email"] == null) {
      return InvalidEmailNotification();
    } else {
      if (map["password"] == null) WeakPasswordNotification();
    }
    var auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: map["email"],
        password: map["password"],
      );
      // User user = auth.currentUser;
      // if (!user.emailVerified) {
      //   await user.sendEmailVerification();
      // }
    } on FirebaseAuthException catch (e) {
      return UserManagementNotification.errorCodes[e.code];
    } catch (e) {
      return UserNotFoundNotification();
    }

    return UserSignupSuccessfulNotification();
  }
}

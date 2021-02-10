import 'package:aussie/models/usermanagement/user/usermanagement_notifs.dart';

abstract class UserManagementNotification {
  static const Map<String, UserManagementNotification> firebaseAuthErrorCodes =
      <String, UserManagementNotification>{
    "invalid-email": InvalidEmailNotification(),
    "wrong-password": WrongPasswordNotification(),
    "email-already-in-use": EmailAlreadyInUseNotification(),
    "user-not-found": UserNotFoundNotification(),
    "weak-password": WeakPasswordNotification(),
    "missing-email": MissingEmailNotification(),
    // "user-mismatch":
    //     "the supplied credentials do not correspond to the previously signed in user.",
    // "requires-recent-login":
    //     "this operation is sensitive and requires recent authentication. log in again before retrying this request.",
    // "account-exists-with-different-credential":
    //     "an account already exists with the same email address but different sign-in credentials. sign in using a provider associated with this email address.",
    // "credential-already-in-use":
    //     "this credential is already associated with a different user account.",
  };
  String get code;
  String get message;
}

import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/user/user.dart';

class WrongNameNotification implements UserManagementNotification {
  @override
  String get code => "";

  const WrongNameNotification();

  @override
  String get message => "The username supplied can't be used";
}

class MissingEmailNotification implements UserManagementNotification {
  @override
  String get code => "missing-email";

  const MissingEmailNotification();

  @override
  String get message => "An email address must be provided";
}

class WeakPasswordNotification implements UserManagementNotification {
  @override
  String get code => "weak-password";
  const WeakPasswordNotification();

  @override
  String get message => "The given password is invalid.";
}

class ProfileImageRequiredNotification implements UserManagementNotification {
  @override
  String get code => "";
  const ProfileImageRequiredNotification();

  @override
  String get message => "A profile image is required";
}

class UserNotFoundNotification implements UserManagementNotification {
  @override
  String get code => "user-not-found";
  const UserNotFoundNotification();

  @override
  String get message =>
      "There is no user record corresponding to this identifier. the user may have been deleted.";
}

class UserManagementErrorNotification implements UserManagementNotification {
  @override
  String get code => "error";
  const UserManagementErrorNotification();

  @override
  String get message =>
      "There is no user record corresponding to this identifier. the user may have been deleted.";
}

class EmailAlreadyInUseNotification implements UserManagementNotification {
  @override
  String get code => "email-already-in-use";
  const EmailAlreadyInUseNotification();

  @override
  String get message =>
      "The email address is already in use by another account.";
}

class WrongPasswordNotification implements UserManagementNotification {
  @override
  String get code => "wrong-password";
  const WrongPasswordNotification();

  @override
  String get message =>
      "The password is invalid or the user does not have a password.";
}

class InvalidEmailNotification implements UserManagementNotification {
  @override
  String get code => "invalid-email";
  const InvalidEmailNotification();

  @override
  String get message => "The email provided is badly formatted";
}

class UserVerifiedNotification implements UserManagementNotification {
  @override
  String get code => "";

  @override
  String get message => "Email verified";
}

class UserSignupSuccessfulNotification implements UserManagementNotification {
  const UserSignupSuccessfulNotification();
  @override
  String get code => "";

  @override
  String get message => "Successfully signed up";
}

class UserSigninSuccessfulNotification implements UserManagementNotification {
  const UserSigninSuccessfulNotification();
  @override
  String get code => "";

  @override
  String get message => "Operation sucsses";
}

class UserHasNotSignedInNotification implements UserManagementNotification {
  const UserHasNotSignedInNotification();
  @override
  String get code => "";

  @override
  String get message => "User has not yet signed in";
}

class UserModelContainingNotification implements UserManagementNotification {
  final Map<String, dynamic> user;

  UserModelContainingNotification(this.user);
  @override
  String get code => "";

  @override
  String get message => "";
}

class UserModelContainingActualNotification
    implements UserManagementNotification {
  final AussieUser user;

  UserModelContainingActualNotification(this.user);
  @override
  String get code => "";

  @override
  String get message => "";
}

class UserMangementUserAttendedEventNotification
    implements UserManagementNotification {
  @override
  String get code => "";

  @override
  String get message => "";
}

class UserMangementUserUnAttendedEventNotification
    implements UserManagementNotification {
  @override
  String get code => "";

  @override
  String get message => "";
}

import 'package:aussie/interfaces/usermanagement_notifs.dart';

class MissingEmailNotification implements UserManagementNotification {
  @override
  String get code => "missing-email";

  MissingEmailNotification._();
  static MissingEmailNotification _instance;
  factory MissingEmailNotification() {
    if (_instance == null) {
      _instance = MissingEmailNotification._();
    }
    return _instance;
  }

  @override
  String get message => "An email address must be provided";
}

class WeakPasswordNotification implements UserManagementNotification {
  @override
  String get code => "weak-password";
  WeakPasswordNotification._();
  static WeakPasswordNotification _instance;
  factory WeakPasswordNotification() {
    if (_instance == null) {
      _instance = WeakPasswordNotification._();
    }
    return _instance;
  }

  @override
  String get message => "The given password is invalid.";
}

class UserNotFoundNotification implements UserManagementNotification {
  @override
  String get code => "user-not-found";
  UserNotFoundNotification._();
  static UserNotFoundNotification _instance;
  factory UserNotFoundNotification() {
    if (_instance == null) {
      _instance = UserNotFoundNotification._();
    }
    return _instance;
  }

  @override
  String get message =>
      "There is no user record corresponding to this identifier. the user may have been deleted.";
}

class EmailAlreadyInUseNotification implements UserManagementNotification {
  @override
  String get code => "email-already-in-use";
  EmailAlreadyInUseNotification._();
  static UserManagementNotification _instance;
  factory EmailAlreadyInUseNotification() {
    if (_instance == null) {
      _instance = EmailAlreadyInUseNotification._();
    }
    return _instance;
  }

  @override
  String get message =>
      "The email address is already in use by another account.";
}

class WrongPasswordNotification implements UserManagementNotification {
  @override
  String get code => "wrong-password";
  WrongPasswordNotification._();
  static WrongPasswordNotification _instance;
  factory WrongPasswordNotification() {
    if (_instance == null) {
      _instance = WrongPasswordNotification._();
    }
    return _instance;
  }

  @override
  String get message =>
      "The password is invalid or the user does not have a password.";
}

class InvalidEmailNotification implements UserManagementNotification {
  @override
  String get code => "invalid-email";
  InvalidEmailNotification._();
  static InvalidEmailNotification _instance;
  factory InvalidEmailNotification() {
    if (_instance == null) {
      _instance = InvalidEmailNotification._();
    }
    return _instance;
  }

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
  @override
  String get code => "";

  @override
  String get message => "Successfully signed up";
}

class UserSigninSuccessfulNotification implements UserManagementNotification {
  @override
  String get code => "";

  @override
  String get message => "Operation sucsses";
}

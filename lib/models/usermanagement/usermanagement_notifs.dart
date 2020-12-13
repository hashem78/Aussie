import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WrongNameNotification implements UserManagementNotification {
  @override
  String get code => "";

  WrongNameNotification._();
  static WrongNameNotification _instance;
  factory WrongNameNotification() {
    if (_instance == null) {
      _instance = WrongNameNotification._();
    }
    return _instance;
  }

  @override
  String get message => "The username supplied can't be used";
}

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

class ProfileImageRequiredNotification implements UserManagementNotification {
  @override
  String get code => "weak-password";
  ProfileImageRequiredNotification._();
  static ProfileImageRequiredNotification _instance;
  factory ProfileImageRequiredNotification() {
    if (_instance == null) {
      _instance = ProfileImageRequiredNotification._();
    }
    return _instance;
  }

  @override
  String get message => "A profile image is required";
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

class UserManagementErrorNotification implements UserManagementNotification {
  @override
  String get code => "error";
  UserManagementErrorNotification._();
  static UserManagementErrorNotification _instance;
  factory UserManagementErrorNotification() {
    if (_instance == null) {
      _instance = UserManagementErrorNotification._();
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

class UserHasNotSignedInNotification implements UserManagementNotification {
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

class EventModelsContainingNotification extends UserManagementNotification {
  final DocumentSnapshot prevsnap;
  final List<Map<String, dynamic>> eventModels;

  EventModelsContainingNotification({
    this.prevsnap,
    this.eventModels,
  });

  @override
  String get code => "";

  @override
  String get message => "";
}

class EventModelsContainingActualNotification
    extends UserManagementNotification {
  final List<EventModel> models;

  EventModelsContainingActualNotification(this.models);

  @override
  String get code => "";

  @override
  String get message => "";
}

import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'interfaces/iuser_management_notifications.dart';

class UMWrongName implements IUMNotification {
  @override
  String get code => '';

  const UMWrongName();

  @override
  String get message => "The username supplied can't be used";
}

class UMMissingEmail implements IUMNotification {
  @override
  String get code => 'missing-email';

  const UMMissingEmail();

  @override
  String get message => 'An email address must be provided';
}

class UMWeakPassword implements IUMNotification {
  @override
  String get code => 'weak-password';
  const UMWeakPassword();

  @override
  String get message => 'The given password is invalid.';
}

class UMProfileImageRequired implements IUMNotification {
  @override
  String get code => '';
  const UMProfileImageRequired();

  @override
  String get message => 'A profile image is required';
}

class UMUserNotFound implements IUMNotification {
  @override
  String get code => 'user-not-found';
  const UMUserNotFound();

  @override
  String get message =>
      'There is no user record corresponding to this identifier. the user may have been deleted.';
}

class UMError implements IUMNotification {
  @override
  String get code => 'error';
  const UMError();

  @override
  String get message => 'An unknown error occured, try again later!';
}

class UMEmailAlreadyInUse implements IUMNotification {
  @override
  String get code => 'email-already-in-use';
  const UMEmailAlreadyInUse();

  @override
  String get message =>
      'The email address is already in use by another account.';
}

class UMWrongPassword implements IUMNotification {
  @override
  String get code => 'wrong-password';
  const UMWrongPassword();

  @override
  String get message =>
      'The password is invalid or the user does not have a password.';
}

class UMInvalidEmail implements IUMNotification {
  @override
  String get code => 'invalid-email';
  const UMInvalidEmail();

  @override
  String get message => 'The email provided is badly formatted';
}

class UMUserVerified implements IUMNotification {
  @override
  String get code => '';

  @override
  String get message => 'Email verified';
}

class UMSignupSuccessful implements IUMNotification {
  const UMSignupSuccessful();
  @override
  String get code => '';

  @override
  String get message => 'Successfully signed up';
}

class UMSigninSuccessful implements IUMNotification {
  const UMSigninSuccessful();
  @override
  String get code => '';

  @override
  String get message => 'Operation sucsses';
}

class UMNotSignedIn implements IUMNotification {
  const UMNotSignedIn();
  @override
  String get code => '';

  @override
  String get message => 'User has not yet signed in';
}

class UMModelContaining implements IUMNotification {
  final Map<String, dynamic> user;

  UMModelContaining(this.user);
  @override
  String get code => '';

  @override
  String get message => '';
}

class UMModelContainingActual implements IUMNotification {
  final AussieUser user;

  UMModelContainingActual(this.user);
  @override
  String get code => '';

  @override
  String get message => '';
}

class UMAttendedEvent implements IUMNotification {
  @override
  String get code => '';

  @override
  String get message => '';
}

class UMUnAttendedEvent implements IUMNotification {
  @override
  String get code => '';

  @override
  String get message => '';
}

const Map<String, IUMNotification> firebaseAuthErrorCodes =
    <String, IUMNotification>{
  'invalid-email': UMInvalidEmail(),
  'wrong-password': UMWrongPassword(),
  'email-already-in-use': UMEmailAlreadyInUse(),
  'user-not-found': UMUserNotFound(),
  'weak-password': UMWeakPassword(),
  'missing-email': UMMissingEmail(),
  // 'user-mismatch': '',
  // 'requires-recent-login': '',
  // 'account-exists-with-different-credential': '',
  // 'credential-already-in-use':'',
};

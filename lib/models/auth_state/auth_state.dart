import 'package:evento/models/usermanagement/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.good() = _AuthStateGood;
  const factory AuthState.goodSignup(AussieUser user) = _AuthStateGoodSignup;

  const factory AuthState.bad() = _AuthStateBad;
  const factory AuthState.invalidEmail() = _AuthStateInvalidEmail;
  const factory AuthState.weakPassword() = _AuthStateWeakPassword;
  const factory AuthState.emailAlreadyInUser() = _AuthStateEmailAlreadyInUse;
  const factory AuthState.userNotFound() = _AuthStateUsernNotFound;
  const factory AuthState.wrongPassword() = _AuthStateWrongPassword;
  const factory AuthState.invalidUserName() = _AuthStateInvalidUserName;
  const factory AuthState.profileImageInvalid() = _AuthStateProfileImageInvalid;
  const factory AuthState.userMisMatch() = _AuthStateUserMisMatch;
  const factory AuthState.requiredRecentLogin() = _AuthStateRequiredRecentLogin;
  const factory AuthState.accountExistsWithDifferentCredential() =
      _AuthStateAccountExistsWithDifferentCredential;
  const factory AuthState.credentailAlreadyInUse() =
      _AuthStateCredentailAlreadyInUse;
}

const firebaseAuthErrorCodes = {
  'invalid-email': AuthState.invalidEmail(),
  'wrong-password': AuthState.wrongPassword(),
  'email-already-in-use': AuthState.emailAlreadyInUser(),
  'user-not-found': AuthState.userNotFound(),
  'weak-password': AuthState.weakPassword(),
  'missing-email': AuthState.invalidEmail(),
  'user-mismatch': AuthState.userMisMatch(),
  'requires-recent-login': AuthState.requiredRecentLogin(),
  'account-exists-with-different-credential':
      AuthState.accountExistsWithDifferentCredential(),
  'credential-already-in-use': AuthState.credentailAlreadyInUse(),
};

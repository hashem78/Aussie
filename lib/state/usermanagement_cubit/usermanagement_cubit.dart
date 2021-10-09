import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
import 'package:aussie/repositories/usermanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'usermanagement_state.dart';

class UMCubit extends Cubit<UMCState> {
  UMCubit() : super(const UMCInitial());
  final UserManagementRepository repository = UserManagementRepository();

  void signup(SignupModel model) {
    emit(const UMCPerformingAction());

    repository.signup(model).then(
      (IUMNotification? value) {
        if (value is UMSignupSuccessful) {
          emit(UMCSignup(value));
        } else {
          emit(UMCError(value));
        }
      },
    );
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    emit(const UMCSignOut());
  }

  void singin(SigninModel model) {
    emit(const UMCPerformingAction());
    repository.signin(model).then(
      (IUMNotification? value) {
        if (value is UMSigninSuccessful) {
          emit(const UMCSignin());
        } else {
          emit(UMCError(value));
        }
      },
    );
  }

  void isUserSignedIn() {
    emit(const UMCPerformingAction());

    repository.isSignedin().then(
      (IUMNotification value) {
        if (value is UMSigninSuccessful) {
          emit(const UMCSignin());
        } else {
          emit(const UMCNeedsAction());
        }
      },
    );
  }

  void getUserData() {
    repository.getUserData().then(
      (IUMNotification? value) {
        if (value is UMModelContainingActual) {
          emit(UMCHasUserData(value.user));
        } else {
          emit(UMCError(value));
        }
      },
    );
  }

  void getUserDataFromUid(String? uid) {
    repository.getUserDataFromUid(uid).then(
      (IUMNotification value) {
        if (value is UMModelContainingActual) {
          emit(UMCHasUserData(value.user));
        } else {
          emit(UMCError(value));
        }
      },
    );
  }

  void emitInitial() {
    emit(const UMCInitial());
  }

  void emitNeedsAction() {
    emit(const UMCNeedsAction());
  }
}

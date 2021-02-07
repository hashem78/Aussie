import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:aussie/repositories/usermanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'usermanagement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(const UserManagementInitial());
  final UserManagementRepository repository = UserManagementRepository();

  void signup(SignupModel model) {
    emit(UserManagementPerformingAction());

    repository.signup(model).then(
      (value) {
        if (value is UserSignupSuccessfulNotification) {
          emit(UserManagementSignup(value));
        } else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    emit(const UserManagementSignOut());
  }

  void singin(SigninModel model) {
    emit(UserManagementPerformingAction());
    repository.signin(model).then(
      (value) {
        if (value is UserSigninSuccessfulNotification) {
          emit(const UserManagementSignin());
        } else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  void isUserSignedIn() {
    emit(UserManagementPerformingAction());

    repository.isSignedin().then(
      (value) {
        if (value is UserSigninSuccessfulNotification) {
          emit(const UserManagementSignin());
        } else {
          emit(UserManagementNeedsAction());
        }
      },
    );
  }

  void getUserData() {
    repository.getUserData().then(
      (value) {
        if (value is UserModelContainingActualNotification) {
          emit(UserMangementHasUserData(value.user));
        } else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  void getUserDataFromUid(String uid) {
    repository.getUserDataFromUid(uid).then(
      (value) {
        if (value is UserModelContainingActualNotification) {
          emit(UserMangementHasUserData(value.user));
        } else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  void makeUserWithIdAttendEvent(AussieUser user, String eventUuid) {
    emit(UserManagementPerformingAction());

    repository
        .makeUserWithIdAttendEvent(
      user.uid,
      eventUuid,
    )
        .then(
      (value) {
        if (value is UserMangementUserAttendedEventNotification) {
          emit(const UserManagementAttended());
        } else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  void isUserAttending(AussieUser user, EventModel eventModel) {
    if (user.attends.contains(eventModel.eventId)) {
      emit(const UserManagementAttended());
    }
  }

  void emitInitial() {
    emit(const UserManagementInitial());
  }

  void emitNeedsAction() {
    emit(UserManagementNeedsAction());
  }
}

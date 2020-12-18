import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/event/event.dart';

import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:aussie/repositories/usermanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'usermanagement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitial());
  final UserManagementRepository repository = UserManagementRepository();

  void signup(SignupModel model) {
    emit(UserManagementPerformingAction());

    repository.signup(model).then(
      (value) {
        if (value is UserSignupSuccessfulNotification)
          emit(UserManagementSignup(value));
        else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  void singin(SigninModel model) {
    emit(UserManagementPerformingAction());
    repository.signin(model).then(
      (value) {
        if (value is UserSigninSuccessfulNotification) {
          emit(UserManagementSignin());
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
          emit(UserManagementSignin());
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
          emit(UserManagementAttended());
        } else {
          emit(UserManagementError(value));
        }
      },
    );
  }

  void isUserAttending(AussieUser user, EventModel eventModel) {
    if (user.attends.contains(eventModel.eventId)) {
      emit(UserManagementAttended());
    }
  }

  void emitInitial() {
    emit(UserManagementInitial());
  }
}

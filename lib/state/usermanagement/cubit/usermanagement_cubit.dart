import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:aussie/repositories/usermanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'usermanagement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitial());
  UserManagementRepository repository = UserManagementRepository();
  void signup(SignupModel model) {
    emit(UserManagementPerformingAction());

    repository.signup(model).then(
      (value) {
        if (value is UserSigninSuccessfulNotification)
          emit(UserManagementSignup(value));
        else {
          emit(UserManagementSignupError(value));
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
          emit(UserManagementSigninError(value));
        }
      },
    );
  }

  void isUserSignedIn() {
    emit(UserManagementPerformingAction());

    repository.signedin().then(
      (value) {
        if (value == null) {
          emit(UserManagementNeedsAction());
        } else {
          emit(UserManagementSignin());
        }
      },
    );
  }
}

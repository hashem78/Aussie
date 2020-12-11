import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/repositories/usermanagement_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'usermanagement_state.dart';

class UserManagementCubit extends Cubit<UserManagementState> {
  UserManagementCubit() : super(UserManagementInitial());
  UserManagementRepository repository = UserManagementRepository();
  void signup(SignupModel model) {
    repository.signup(model).then(
      (value) {
        if (value.first != null) {
          emit(UserManagementSignup(value.first));
        } else if (value.second != null) {
          emit(UserManagementSignupError(value.second));
        }
      },
    );
  }

  void singin(SigninModel model) {
    repository.signin(model).then(
      (value) {
        if (value.first != null) {
          emit(UserManagementSignup(value.first));
        } else if (value.second != null) {
          emit(UserManagementSignupError(value.second));
        }
      },
    );
  }
}

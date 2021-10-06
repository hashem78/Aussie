part of 'usermanagement_cubit.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();

  @override
  List<Object?> get props => <Object?>[];
}

class UserManagementInitial extends UserManagementState {
  const UserManagementInitial();
}

class UserManagementAttended extends UserManagementState {
  const UserManagementAttended();
}

class UserManagementSignOut extends UserManagementState {
  const UserManagementSignOut();
}

class UserManagementSignup extends UserManagementState {
  final UserManagementNotification notification;

  const UserManagementSignup(this.notification);
  @override
  List<Object> get props => <Object>[notification];
}

class UserManagementSignin extends UserManagementState {
  const UserManagementSignin();
}

class UserManagementError extends UserManagementState {
  final UserManagementNotification? notification;

  const UserManagementError(this.notification);
  @override
  List<Object?> get props => <Object?>[notification];
}

class UserManagementNeedsAction extends UserManagementState {}

class UserManagementPerformingAction extends UserManagementState {}

class UserMangementHasUserData extends UserManagementState {
  final AussieUser user;

  const UserMangementHasUserData(this.user);
  @override
  List<Object> get props => <Object>[user];
}

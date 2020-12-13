part of 'usermanagement_cubit.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();

  @override
  List<Object> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class UserManagementSignup extends UserManagementState {
  final UserManagementNotification notification;

  UserManagementSignup(this.notification);
  @override
  List<Object> get props => [notification];
}

class UserManagementSignin extends UserManagementState {
  UserManagementSignin();
}

class UserManagementError extends UserManagementState {
  final UserManagementNotification notification;

  UserManagementError(this.notification);
  @override
  List<Object> get props => [notification];
}

class UserManagementNeedsAction extends UserManagementState {}

class UserManagementPerformingAction extends UserManagementState {}

class UserMangementHasUserData extends UserManagementState {
  final AussieUser user;

  UserMangementHasUserData(this.user);
  @override
  List<Object> get props => [user];
}

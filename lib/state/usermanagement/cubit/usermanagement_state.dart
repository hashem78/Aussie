part of 'usermanagement_cubit.dart';

abstract class UserManagementState extends Equatable {
  const UserManagementState();

  @override
  List<Object> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class UserManagementSignup extends UserManagementState {
  final AussieUser user;

  UserManagementSignup(this.user);
  @override
  List<Object> get props => [user];
}

class UserManagementSignupError extends UserManagementState {
  final UserManagementNotification notification;

  UserManagementSignupError(this.notification);
}

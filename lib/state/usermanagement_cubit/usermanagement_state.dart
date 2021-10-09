part of 'usermanagement_cubit.dart';

abstract class UMCState extends Equatable {
  const UMCState();

  @override
  List<Object?> get props => <Object?>[];
}

class UMCInitial extends UMCState {
  const UMCInitial();
}

class UMCAttended extends UMCState {
  const UMCAttended();
}

class UMCSignOut extends UMCState {
  const UMCSignOut();
}

class UMCSignup extends UMCState {
  final IUMNotification notification;

  const UMCSignup(this.notification);
  @override
  List<Object> get props => <Object>[notification];
}

class UMCSignin extends UMCState {
  const UMCSignin();
}

class UMCError extends UMCState {
  final IUMNotification? notification;

  const UMCError(this.notification);
  @override
  List<Object?> get props => <Object?>[notification];
}

class UMCNeedsAction extends UMCState {
  const UMCNeedsAction();
}

class UMCPerformingAction extends UMCState {
  const UMCPerformingAction();
}

class UMCHasUserData extends UMCState {
  final AussieUser user;

  const UMCHasUserData(this.user);
  @override
  List<Object> get props => <Object>[user];
}

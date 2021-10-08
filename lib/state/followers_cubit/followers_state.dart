part of 'followers_cubit.dart';

abstract class FollowersState extends Equatable {
  const FollowersState();

  @override
  List<Object> get props => const <Object>[];
}

class FollowersInitial extends FollowersState {
  const FollowersInitial();
}

class FollowersWorking extends FollowersState {
  const FollowersWorking();
}

class FollowingUser extends FollowersState {
  const FollowingUser();
}

class NotFollowingUser extends FollowersState {
  const NotFollowingUser();
}

class FollowedUser extends FollowersState {
  const FollowedUser();
}

class UnFollowedUser extends FollowersState {
  const UnFollowedUser();
}

class FollowersErrorState extends FollowersState {
  const FollowersErrorState();
}

class FollowersHasUsersList extends FollowersState {
  final UnmodifiableListView<AussieUser> users;

  const FollowersHasUsersList(this.users);
}

class FollowersHasUsersEndList extends FollowersState {
  final UnmodifiableListView<AussieUser> users;

  const FollowersHasUsersEndList(this.users);
}

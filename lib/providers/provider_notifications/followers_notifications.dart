import 'package:aussie/aussie_imports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';

abstract class FollowersNotification {
  const FollowersNotification();
}

class FSucess extends FollowersNotification {}

class FError extends FollowersNotification {
  final String error;

  const FError(this.error);
}

class FUserIsFollowed extends FollowersNotification {
  const FUserIsFollowed();
}
class FUserIsNotFollowed extends FollowersNotification {
  const FUserIsNotFollowed();
}
class FFollowedUser extends FollowersNotification {
  const FFollowedUser();
}

class FUnFollowedUser extends FollowersNotification {
  const FUnFollowedUser();
}

class FFollowerList extends FollowersNotification {
  final UnmodifiableListView<String> users;
  final DocumentSnapshot<Object?>? prevSnap;

  const FFollowerList({
    required this.users,
    this.prevSnap,
  });
}

class FFollowerEndList extends FollowersNotification {
  final UnmodifiableListView<String> users;

  const FFollowerEndList({
    required this.users,
  });
}

class FAussieUserList extends FollowersNotification {
  final UnmodifiableListView<AussieUser> users;
  final DocumentSnapshot<Object?>? prevSnap;

  const FAussieUserList({
    required this.users,
    this.prevSnap,
  });
}

class FAussieUserEndList extends FollowersNotification {
  final UnmodifiableListView<AussieUser> users;
  const FAussieUserEndList({
    required this.users,
  });
}

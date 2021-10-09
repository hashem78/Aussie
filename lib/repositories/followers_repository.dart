import 'dart:collection';

import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/followers_provider.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowersRepository {
  final FollowersProvider _provider = FollowersProvider();

  Future<bool> isUserFollowed(String uid) async {
    final FollowersNotification notification =
        await _provider.isUserFollowed(uid);
    if (notification is FUserIsFollowed) {
      return true;
    } else {
      return false;
    }
  }

  Future<FollowersNotification> followUser(String uid) async {
    final FollowersNotification notification = await _provider.followUser(uid);

    return notification;
  }

  Future<FollowersNotification> unFollowUser(String uid) async {
    final FollowersNotification notification =
        await _provider.unFollowUser(uid);

    return notification;
  }

  Future<FollowersNotification> getFollowersForUser(
      String uid, DocumentSnapshot<Object?>? documentSnapshot) async {
    final FollowerUserData ids = await _provider.getFollowersForUser(
      uid,
      documentSnapshot,
    );

    final UnmodifiableListView<AussieUser> users =
        await _provider.getUsers(ids.item1);

    if (ids.item2 != null) {
      return FAussieUserList(
        users: users,
        prevSnap: ids.item2,
      );
    } else {
      return FAussieUserEndList(
        users: users,
      );
    }
  }

  Future<FollowersNotification> getFollowingForUser(
    String uid,
    DocumentSnapshot<Object?>? documentSnapshot,
  ) async {
    final FollowerUserData ids = await _provider.getFollowingForUser(
      uid,
      documentSnapshot,
    );

    final UnmodifiableListView<AussieUser> users = await _provider.getUsers(
      ids.item1,
    );
    if (ids.item2 != null) {
      return FAussieUserList(
        users: users,
        prevSnap: ids.item2,
      );
    } else {
      return FAussieUserEndList(
        users: users,
      );
    }
  }
}

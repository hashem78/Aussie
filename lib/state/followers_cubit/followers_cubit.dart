import 'dart:collection';

import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';
import 'package:aussie/repositories/followers_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'followers_state.dart';

class FollowersCubit extends Cubit<FollowersState> {
  FollowersCubit() : super(const FollowersInitial());

  final FollowersRepository repository = FollowersRepository();
  DocumentSnapshot<Object?>? prevSnap;
  void isUserFollowed(String uid) {
    emit(const FollowersWorking());
    repository.isUserFollowed(uid).then(
      (bool isFollowed) {
        if (isFollowed) {
          emit(const FollowingUser());
        } else {
          emit(const NotFollowingUser());
        }
      },
    );
  }

  void followUser(String uid) {
    emit(const FollowersWorking());
    repository.followUser(uid).then(
      (FollowersNotification value) {
        if (value is FFollowedUser) {
          emit(const FollowedUser());
        } else {
          emit(const FollowersErrorState());
        }
      },
    );
  }

  void unFollowUser(String uid) {
    emit(const FollowersWorking());
    repository.unFollowUser(uid).then(
      (FollowersNotification value) {
        if (value is FUnFollowedUser) {
          emit(const UnFollowedUser());
        } else {
          emit(const FollowersErrorState());
        }
      },
    );
  }

  void getFollowersForUser(String uid) {
    repository.getFollowersForUser(uid, prevSnap).then(
      (FollowersNotification value) {
        if (value is FAussieUserList) {
          prevSnap = value.prevSnap;
          emit(FollowersHasUsersList(value.users));
        } else if (value is FAussieUserEndList) {
          emit(FollowersHasUsersEndList(value.users));
        }
      },
    );
  }

  void getFollowingForUser(
    String uid,
  ) {
    repository.getFollowingForUser(uid, prevSnap).then(
      (FollowersNotification value) {
        if (value is FAussieUserList) {
          prevSnap = value.prevSnap;
          emit(FollowersHasUsersList(value.users));
        } else if (value is FAussieUserEndList) {
          emit(FollowersHasUsersEndList(value.users));
        }
      },
    );
  }

  void reset() {
    prevSnap = null;
    emit(const FollowersInitial());
  }
}

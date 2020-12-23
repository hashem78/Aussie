import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:aussie/providers/usermanagement.dart';

class UserManagementRepository {
  final UserManagementProvider _provider = UserManagementProvider();
  Future<UserManagementNotification> signup(SignupModel model) async =>
      _provider.signup(model.toJson());

  Future<UserManagementNotification> signin(SigninModel model) async =>
      _provider.signin(model.toJson());

  Future<UserManagementNotification> isSignedin() async =>
      _provider.isSignedin();

  Future<UserManagementNotification> getUserData() async {
    final UserManagementNotification notification =
        await _provider.getUserData();
    if (notification is UserModelContainingNotification) {
      return UserModelContainingActualNotification(
        AussieUser.fromJson(notification.user),
      );
    } else {
      return notification;
    }
  }

  Future<UserManagementNotification> getUserDataFromUid(String uid) async {
    final UserManagementNotification notification =
        await _provider.getUserDataFromUid(uid);
    if (notification is UserModelContainingNotification) {
      return UserModelContainingActualNotification(
        AussieUser.fromJson(notification.user),
      );
    } else {
      return notification;
    }
  }

  Future<UserManagementNotification> makeUserWithIdAttendEvent(
      String uid, String eventUuid) async {
    return _provider.makeUserWithIdAttendEvent(uid, eventUuid);
  }
}

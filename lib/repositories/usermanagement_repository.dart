import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/providers/provider_notifications/provider_notifications.dart';

import 'package:aussie/providers/usermanagement_provider.dart';

class UserManagementRepository {
  final UserManagementProvider _provider = UserManagementProvider();
  Future<IUMNotification?> signup(SignupModel model) async =>
      _provider.signup(model.toJson());

  Future<IUMNotification?> signin(SigninModel model) async =>
      _provider.signin(model.toJson());

  Future<IUMNotification> isSignedin() async => _provider.isSignedin();

  Future<IUMNotification?> getUserData() async {
    final IUMNotification? notification = await _provider.getUserData();
    if (notification is UMModelContaining) {
      return UMModelContainingActual(
        AussieUser.fromJson(notification.user),
      );
    } else {
      return notification;
    }
  }

  Future<IUMNotification> getUserDataFromUid(String? uid) async {
    final IUMNotification notification =
        await _provider.getUserDataFromUid(uid);
    if (notification is UMModelContaining) {
      return UMModelContainingActual(
        AussieUser.fromJson(notification.user),
      );
    } else {
      return notification;
    }
  }

  Future<IUMNotification> makeUserWithIdAttendEvent(
      String? uid, String? eventUuid) async {
    return _provider.makeUserWithIdAttendEvent(uid, eventUuid);
  }
}

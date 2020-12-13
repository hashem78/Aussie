import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:aussie/providers/usermanagement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagementRepository {
  UserManagementProvider _provider = UserManagementProvider();
  Future<UserManagementNotification> signup(SignupModel model) async =>
      await _provider.signup(model.toJson());

  Future<UserManagementNotification> signin(SigninModel model) async =>
      await _provider.signin(model.toJson());

  Future<UserManagementNotification> isSignedin() async {
    return await _provider.isSignedin();
  }

  Future<UserManagementNotification> getUserData() async {
    UserManagementNotification notification = await _provider.getUserData();
    if (notification is UserModelContainingNotification)
      return UserModelContainingActualNotification(
        AussieUser.fromJson(notification.user),
      );
    else
      return notification;
  }

  Future<UserManagementNotification> getUserDataFromUid(String uid) async {
    UserManagementNotification notification =
        await _provider.getUserDataFromUid(uid);
    if (notification is UserModelContainingNotification)
      return UserModelContainingActualNotification(
        AussieUser.fromJson(notification.user),
      );
    else
      return notification;
  }

  Future<UserManagementNotification> fetchEvents(
    DocumentSnapshot prevSnap,
  ) async {
    UserManagementNotification notification =
        await _provider.fetchEvents(prevSnap);
    if (notification is EventModelsContainingNotification) {
      List<EventModel> models = [];
      notification.eventModels.forEach(
        (element) {
          models.add(EventModel.fromJson(element));
        },
      );
      return EventModelsContainingActualNotification(models);
    } else {
      return notification;
    }
  }
}

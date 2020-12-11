import 'package:aussie/interfaces/usermanagement_notifs.dart';
import 'package:aussie/models/signin_model/signin_model.dart';
import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/usermanagement_notifs.dart';
import 'package:aussie/providers/usermanagement.dart';
import 'package:aussie/util/pair.dart';

class UserManagementRepository {
  UserManagementProvider _provider = UserManagementProvider();
  Future<Pair<AussieUser, UserManagementNotification>> signup(
      SignupModel model) async {
    var _notif = await _provider.signup(model.toJson());
    if (_notif is UserSignupSuccessfulNotification) {
      return Pair(AussieUser(), null);
    }
    return Pair(null, _notif);
  }

  Future<Pair<AussieUser, UserManagementNotification>> signin(
      SigninModel model) async {
    var _notif = await _provider.signup(model.toJson());
    if (_notif is UserSignupSuccessfulNotification) {
      return Pair(AussieUser(), null);
    }
    return Pair(null, _notif);
  }
}

class AussieUser {}

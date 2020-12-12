import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';

import 'package:aussie/interfaces/usermanagement_notifs.dart';

import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/models/usermanagement/user/user.dart';

import 'package:aussie/providers/usermanagement.dart';

class UserManagementRepository {
  UserManagementProvider _provider = UserManagementProvider();
  Future<UserManagementNotification> signup(SignupModel model) async =>
      await _provider.signup(model.toJson());

  Future<UserManagementNotification> signin(SigninModel model) async =>
      await _provider.signin(model.toJson());

  Future<AussieUser> signedin() async {
    var _data = await _provider.signedin();

    if (_data == null) return null;
    return AussieUser.fromJson(_data);
  }
}

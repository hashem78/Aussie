import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_model.g.dart';
part 'signup_model.freezed.dart';

@freezed
class SignupModel with _$SignupModel {
  const factory SignupModel({
    String? email,
    String? password,
    String? profileImagePath,
    String? username,
    String? fullname,
  }) = _SignupModel;
  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
}

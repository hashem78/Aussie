import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_model.g.dart';
part 'signin_model.freezed.dart';

@freezed
class SigninModel with _$SigninModel {
  const factory SigninModel(
    String email,
    String password,
  ) = _SigninModel;

  factory SigninModel.fromJson(Map<String, dynamic> json) =>
      _$SigninModelFromJson(json);
}

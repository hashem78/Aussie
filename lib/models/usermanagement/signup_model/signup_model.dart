import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable(
  createFactory: true,
  checked: true,
  createToJson: true,
)
@immutable
class SignupModel extends Equatable {
  final String email;
  final String password;
  final String profileImagePath;
  SignupModel(this.email, this.password, this.profileImagePath);
  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupModelToJson(this);

  @override
  List<Object> get props => [email, password];
  @override
  bool get stringify => true;
}

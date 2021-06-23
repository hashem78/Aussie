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
  final String? email;
  final String? password;
  final String? profileImagePath;
  final String? username;
  final String? fullname;
  const SignupModel({
    required this.email,
    required this.password,
    required this.profileImagePath,
    required this.username,
    required this.fullname,
  });
  factory SignupModel.fromJson(Map<String, dynamic> json) =>
      _$SignupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupModelToJson(this);

  @override
  List<Object?> get props => [
        email,
        password,
        profileImagePath,
        username,
        fullname,
      ];
  @override
  bool get stringify => true;
}

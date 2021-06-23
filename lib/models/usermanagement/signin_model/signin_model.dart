import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signin_model.g.dart';

@JsonSerializable(
  createFactory: true,
  checked: true,
  createToJson: true,
)
@immutable
class SigninModel extends Equatable {
  final String? email;
  final String? password;
  const SigninModel(this.email, this.password);

  Map<String, dynamic> toJson() => _$SigninModelToJson(this);
  factory SigninModel.fromJson(Map<String, dynamic> json) =>
      _$SigninModelFromJson(json);

  @override
  List<Object?> get props => [email, password];
  @override
  bool get stringify => true;
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class DYKModel extends Equatable {
  final String text;
  DYKModel({this.text});
  @override
  List<Object> get props => [text];
}

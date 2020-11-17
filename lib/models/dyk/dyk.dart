import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class DYKModel extends Equatable {
  final String text;
  DYKModel({
    this.text,
  });
  @override
  List<Object> get props => [text];

  DYKModel copyWith({
    String text,
  }) {
    return DYKModel(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory DYKModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DYKModel(
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DYKModel.fromJson(String source) =>
      DYKModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}

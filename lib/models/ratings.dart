import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class RatingsModel extends Equatable {
  final double rating;
  final String commentOwner;
  final String reviewText;
  const RatingsModel(
    this.rating,
    this.commentOwner,
    this.reviewText,
  ) : assert(rating != null && commentOwner != null && reviewText != null);

  @override
  List<Object> get props => [rating, commentOwner, reviewText];

  RatingsModel copyWith({
    double rating,
    String commentOwner,
    String reviewText,
  }) {
    return RatingsModel(
      rating ?? this.rating,
      commentOwner ?? this.commentOwner,
      reviewText ?? this.reviewText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'commentOwner': commentOwner,
      'reviewText': reviewText,
    };
  }

  factory RatingsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RatingsModel(
      map['rating'],
      map['commentOwner'],
      map['reviewText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingsModel.fromJson(String source) =>
      RatingsModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class GalleryImageModel extends Equatable {
  final String url;
  final String title;

  const GalleryImageModel({
    this.url,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
    };
  }

  factory GalleryImageModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GalleryImageModel(
      url: map['url'],
      title: map['title'],
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [url, title];
}

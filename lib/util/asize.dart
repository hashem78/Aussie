import 'package:flutter/foundation.dart';

@immutable
class ASize {
  final int? width;
  final int? height;

  const ASize(
    this.width,
    this.height,
  );

  @override
  String toString() => 'ASize(width: $width, height: $height)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ASize && other.width == width && other.height == height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;
}

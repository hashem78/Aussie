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
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ASize && o.width == width && o.height == height;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode;
}

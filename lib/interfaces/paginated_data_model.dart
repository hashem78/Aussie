import 'package:flutter/foundation.dart';

@immutable
abstract class PaginatedDataModel {
  Map<String, dynamic> get toJson;
}

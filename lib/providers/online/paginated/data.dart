import 'package:flutter/foundation.dart';

@immutable
abstract class PaginatedDataProvider {
  Future<Map<String, dynamic>> fetch(int page, {int fetchAmount = 10});
}

import 'package:aussie/interfaces/paginated_data_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PaginatedRepository {
  Future<List<PaginatedDataModel>> fetch(int page, {int fetchAmount});
}

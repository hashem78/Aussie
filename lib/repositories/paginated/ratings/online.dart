import 'dart:collection';

import 'package:aussie/models/ratings.dart';
import 'package:aussie/providers/online/paginated/ratings/online.dart';

class PaginatedOnlineRatingsRepository {
  final PaginatedOnlineRatingsProvider _onlineRatingsRepositoryProvider;
  PaginatedOnlineRatingsRepository(
    String ratingsId,
  ) : _onlineRatingsRepositoryProvider =
            PaginatedOnlineRatingsProvider(ratingsId);

  Future<List<RatingsModel>> fetch(int page, {int fetchAmount}) async {
    var _fetched = await _onlineRatingsRepositoryProvider.fetch(
      page,
      fetchAmount: fetchAmount,
    );
    List<RatingsModel> models = [];
    _fetched.forEach((element) => models.add(RatingsModel.fromMap(element)));
    return UnmodifiableListView(models);
  }

  Future<List<RatingsModel>> getSpecificAmount(int fetchAmount) async {
    var _fetched =
        await _onlineRatingsRepositoryProvider.getSpecificAmount(fetchAmount);
    List<RatingsModel> models = [];
    _fetched.forEach((element) => models.add(RatingsModel.fromMap(element)));
    return UnmodifiableListView(models);
  }

  Future<void> addRating(RatingsModel model) async {
    await _onlineRatingsRepositoryProvider.addRating(model.toMap());
  }
}

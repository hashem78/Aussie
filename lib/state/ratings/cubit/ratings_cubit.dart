import 'package:aussie/models/ratings.dart';
import 'package:aussie/repositories/paginated/ratings/online.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit(String ratingsRoute, String id)
      : _repository = PaginatedOnlineRatingsRepository(ratingsRoute, id),
        super(RatingsInitial());
  PaginatedOnlineRatingsRepository _repository;
  Future<void> fetch(int page, {int fetchAmount}) async {
    var _val = await _repository.fetch(page, fetchAmount: fetchAmount);
    if (_val.isEmpty) {
      emit(RatingsEmpty());
    } else {
      emit(RatingsDataChanged(_val));
    }
  }

  void getSpecificAmount(int fetchAmount) {
    _repository
        .getSpecificAmount(fetchAmount)
        .then((value) => emit(RatingsDataChanged(value)));
  }

  Future<void> addRating(RatingsModel model) async {
    await _repository.addRating(model).whenComplete(() {
      emit(RatingAdded());
    });
  }
}

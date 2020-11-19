import 'package:aussie/models/ratings.dart';
import 'package:aussie/repositories/paginated/ratings/online.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit(String id)
      : _repository = PaginatedOnlineRatingsRepository(id),
        super(RatingsInitial());
  PaginatedOnlineRatingsRepository _repository;
  void fetch(int page, {int fetchAmount}) async {
    _repository.fetch(page, fetchAmount: fetchAmount).then(
      (value) {
        if (value.isEmpty) {
          emit(RatingsEmpty());
        } else {
          emit(RatingsDataChanged(value));
        }
      },
    );
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

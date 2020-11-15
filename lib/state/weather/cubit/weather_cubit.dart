import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/repositories/weather/weather.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  OnlineWeatherRepository _repository = OnlineWeatherRepository();
  void fetch(List<LatLng> coords) {
    emit(WeatherLoading());
    _repository.fetch(coords).then(
          (value) => emit(WeatherLoaded(value)),
        );
  }
}

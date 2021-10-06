import 'package:aussie/models/weather/weather_model.dart';
import 'package:aussie/repositories/weather_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  final OnlineWeatherRepository _repository = OnlineWeatherRepository();
  Future<void> fetch(LatLng coord) async {
    final WeatherModel weatherModel = await _repository.fetch(coord);
    emit(WeatherLoaded(weatherModel));
  }
}

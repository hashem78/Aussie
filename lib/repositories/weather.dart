import 'dart:convert';

import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/providers/weather.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OnlineWeatherRepository {
  final WeatherProvider _weatherProvider = WeatherProvider();
  Future<WeatherModel> fetch(LatLng coord) async {
    final _fetched = await _weatherProvider.fetch(coord);
    return WeatherModel.fromJsonWithFourDays(jsonEncode(_fetched));
  }
}

import 'dart:collection';
import 'dart:convert';

import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/providers/online/weather/weather.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OnlineWeatherRepository {
  OnlineWeatherProvider _weatherProvider = OnlineWeatherProvider();
  Future<List<WeatherModel>> fetch(List<LatLng> coords) async {
    var _fetched = await _weatherProvider.fetch(coords);
    List<WeatherModel> ans = [];
    for (var jsonModel in _fetched) {
      ans.add(WeatherModel.fromJsonWithFourDays(jsonEncode(jsonModel)));
    }
    return UnmodifiableListView(ans);
  }
}

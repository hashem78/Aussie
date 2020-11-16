import 'dart:collection';
import 'dart:convert';

import 'package:aussie/constants.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class OnlineWeatherProvider {
  static Map<String, List<int>> _icns = {
    "wi-thunderstorm": [200, 201, 202, 210, 211, 212, 221, 230, 232],
    "wi-raindrops": [
      300,
      301,
      302,
      310,
      311,
      312,
      313,
      314,
      321,
      520,
      521,
      522,
      531,
    ],
    "wi-rain": [500, 501, 502, 503, 504],
    "wi-snow": [511, 600, 601, 602, 611, 612, 613, 615, 616, 620, 621, 622],
    "wi-day-fog": [701, 711, 721, 731, 741, 751, 761, 762, 771, 781],
    "wi-night-clear": [800],
  };
  Future<Map<String, dynamic>> fetch(LatLng coord) async {
    if (!await isConnectedToTheInternet) return error;

    String query =
        "https://api.openweathermap.org/data/2.5/forecast?lat=${coord.latitude}&lon=${coord.longitude}&units=metric&appid=5017190165cca808a48d1eff54927701";
    var _response = await http.get(query);

    if (_response.statusCode == 200) {
      var _decoded = await jsonDecode(_response.body);
      if (_decoded["cod"] == "200") {
        // every day has 8 lists and there are 5 day responses
        Map<int, dynamic> _internalMap = {};
        for (int i = 0; i < 40; i += 8) {
          var element = _decoded["list"][i];
          var _minTemp = element["main"]["temp_min"];
          var _maxTemp = element["main"]["temp_max"];
          var _humidity = element["main"]["humidity"];
          var _pressure = element["main"]["pressure"];
          var _currentWeather = element["weather"][0];
          var _status = _currentWeather["main"];
          var _description = _currentWeather["description"];
          var _icon = _currentWeather["icon"];
          var _statusId = _currentWeather["id"];

          _internalMap[i ~/ 8] = {
            'day': weekDayToString(
              DateTime.fromMillisecondsSinceEpoch(element["dt"] * 1000).weekday,
            ),
            'state': _status,
            'iconString': _statusId >= 800
                ? iconIDToWeatherString(_statusId, _icon)
                : iconIDToWeatherString(_statusId),
            'title': _decoded["city"]["name"],
            'imageUrl': kurl,
            'pressure': double.tryParse(_pressure.toString()),
            'humidity': double.tryParse(_humidity.toString()),
            'highTemp': double.tryParse(_maxTemp.toString()),
            'lowTemp': double.tryParse(_minTemp.toString()),
            'description': _description,
          };
        }
        Map<String, dynamic> _firstDay = _internalMap[0];
        _firstDay["fourDayModels"] = [
          _internalMap[1],
          _internalMap[2],
          _internalMap[3],
          _internalMap[4],
        ];
        return UnmodifiableMapView(_firstDay);
      }
      return error;
    }
    return error;
  }

  Map<String, dynamic> get error => {"-1": "An error occured"};
  Future<bool> get isConnectedToTheInternet async {
    var _status = await DataConnectionChecker().connectionStatus;
    if (_status == DataConnectionStatus.connected) return true;
    return false;
  }

  String iconIDToWeatherString(int id, [String status]) {
    if (id >= 800) {
      assert(status != null, "A status with id greater than 800 can't be null");
      switch (id) {
        case 800:
          if (status.endsWith("d"))
            return "wi-day-sunny";
          else
            return "wi-night-clear";
          break;
        case 801:
          if (status.endsWith("d"))
            return "wi-day-cloudy";
          else
            return "wi-night-cloudy";
          break;
        case 802:
          return "wi-cloud";
          break;
        case 803:
        case 804:
          return "wi-night-cloudy";
      }
    }
    String ans;
    _icns.forEach(
      (key, value) {
        for (var x in value) {
          if (x == id) ans = key;
          break;
        }
      },
    );
    if (ans != null) return ans;
    return "wi-night-clear";
  }

  String weekDayToString(int index) {
    switch (index) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Firday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }
}

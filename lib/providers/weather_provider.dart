import 'dart:collection';
import 'dart:convert';

import 'package:aussie/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WeatherProvider {
  static const Map<String, List<int>> _icns = <String, List<int>>{
    'wi-thunderstorm': <int>[
      200,
      201,
      202,
      210,
      211,
      212,
      221,
      230,
      232,
    ],
    'wi-raindrops': <int>[
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
    'wi-rain': <int>[
      500,
      501,
      502,
      503,
      504,
    ],
    'wi-snow': <int>[
      511,
      600,
      601,
      602,
      611,
      612,
      613,
      615,
      616,
      620,
      621,
      622
    ],
    'wi-day-fog': <int>[
      701,
      711,
      721,
      731,
      741,
      751,
      761,
      762,
      771,
      781,
    ],
    'wi-night-clear': <int>[
      800,
    ],
  };
  Future<Map<String, dynamic>> fetch(LatLng coord) async {
    if (!await isConnectedToTheInternet) return error;

    final String query =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${coord.latitude}&lon=${coord.longitude}&units=metric&appid=5017190165cca808a48d1eff54927701';
    final http.Response _response = await http.get(Uri.tryParse(query)!);

    if (_response.statusCode == 200) {
      final dynamic _decoded = await jsonDecode(_response.body);
      if (_decoded['cod'] == '200') {
        // every day has 8 lists and there are 5 day responses
        final Map<int, dynamic> _internalMap = <int, dynamic>{};
        for (int i = 0; i < 40; i += 8) {
          final dynamic element = _decoded['list'][i];
          final dynamic _minTemp = element['main']['temp_min'];
          final dynamic _maxTemp = element['main']['temp_max'];
          final dynamic _humidity = element['main']['humidity'];
          final dynamic _pressure = element['main']['pressure'];
          final dynamic _currentWeather = element['weather'][0];
          final dynamic _status = _currentWeather['main'];
          final dynamic _description = _currentWeather['description'];
          final String? _icon = _currentWeather['icon'] as String?;
          final int _statusId = _currentWeather['id'] as int;
          final int _dt = element['dt'] * 1000 as int;

          _internalMap[i ~/ 8] = <String, dynamic>{
            'day': weekDayToString(
              DateTime.fromMillisecondsSinceEpoch(_dt).weekday,
            ),
            'state': _status,
            'iconString': _statusId >= 800
                ? iconIDToWeatherString(_statusId, _icon)
                : iconIDToWeatherString(_statusId),
            'title': _decoded['city']['name'],
            'imageUrl': kurl,
            'pressure': double.tryParse(_pressure.toString()),
            'humidity': double.tryParse(_humidity.toString()),
            'highTemp': double.tryParse(_maxTemp.toString()),
            'lowTemp': double.tryParse(_minTemp.toString()),
            'description': _description,
          };
        }
        final Map<String, dynamic> _firstDay =
            _internalMap[0] as Map<String, dynamic>;
        _firstDay['fourDayModels'] = <Map<String, dynamic>>[
          _internalMap[1],
          _internalMap[2],
          _internalMap[3],
          _internalMap[4],
        ];

        return UnmodifiableMapView<String, dynamic>(_firstDay);
      }
      return error;
    }
    return error;
  }

  Map<String, dynamic> get error => <String, String>{'-1': 'An error occured'};
  Future<bool> get isConnectedToTheInternet async {
    final InternetConnectionStatus _status =
        await InternetConnectionChecker().connectionStatus;
    if (_status == InternetConnectionStatus.connected) return true;
    return false;
  }

  String? iconIDToWeatherString(int id, [String? status]) {
    if (id >= 800) {
      assert(status != null, "A status with id greater than 800 can't be null");
      switch (id) {
        case 800:
          if (status!.endsWith('d')) {
            return 'wi-day-sunny';
          } else {
            return 'wi-night-clear';
          }
        case 801:
          if (status!.endsWith('d')) {
            return 'wi-day-cloudy';
          } else {
            return 'wi-night-cloudy';
          }
        case 802:
          return 'wi-cloud';
        case 803:
        case 804:
          return 'wi-night-cloudy';
      }
    }
    String? ans;
    _icns.forEach(
      (String key, List<int> value) {
        for (final int x in value) {
          if (x == id) ans = key;
          break;
        }
      },
    );
    if (ans != null) return ans;
    return 'wi-night-clear';
  }

  String weekDayToString(int index) {
    switch (index) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Firday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}

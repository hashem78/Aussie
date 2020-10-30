import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class WeatherModel extends Equatable {
  final String day;
  final String state;
  final String lowState;
  final String highIconString;
  final String title;
  final String imageUrl;
  final String lowIconString;
  final int highTemp;
  final int lowTemp;
  final List<WeatherModel> fourDayModels;
  const WeatherModel(
      {this.day,
      this.state,
      @required this.highIconString,
      @required this.title,
      this.imageUrl,
      this.highTemp,
      this.lowTemp,
      this.lowState,
      this.lowIconString})
      : assert(title != null && highIconString != null),
        fourDayModels = null;
  const WeatherModel.withFourDays(
      {this.day,
      this.state,
      @required this.highIconString,
      @required this.title,
      @required this.fourDayModels,
      this.imageUrl,
      this.highTemp,
      this.lowState,
      this.lowTemp,
      this.lowIconString})
      : assert(title != null && highIconString != null);

  @override
  List<Object> get props => [day, state, title, highTemp];
}

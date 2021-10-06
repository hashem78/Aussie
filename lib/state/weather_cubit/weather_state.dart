part of 'weather_cubit.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => <Object>[];
}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel model;
  const WeatherLoaded(this.model);
  @override
  List<Object> get props => <Object>[model];
}

class WeatherError extends WeatherState {}

class WeatherLoading extends WeatherState {}

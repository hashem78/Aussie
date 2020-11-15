part of 'weather_cubit.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherModel> models;
  WeatherLoaded(this.models);
  @override
  List<Object> get props => [models];
}

class WeatherError extends WeatherState {}

class WeatherLoading extends WeatherState {}

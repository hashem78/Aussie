import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/dyk.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/main/entertainment.dart';
import 'package:aussie/presentation/screens/main/events.dart';
import 'package:aussie/presentation/screens/main/food_drinks.dart';
import 'package:aussie/presentation/screens/main/people.dart';
import 'package:aussie/presentation/screens/main/places.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(Map<String, dynamic> themeMap)
      : super(ThemeChanged(ThemeModel.fromMap(themeMap)));
  void changeTheme({
    Brightness brightness,
    AussieColorData peopleScreenColor,
    AussieColorData foodScreenColor,
    AussieColorData eventsScreenColor,
    AussieColorData placesScreenColor,
    AussieColorData entertainmentScreenColor,
    AussieColorData faunaScreenColor,
    AussieColorData floraScreenColor,
    AussieColorData teritoriesScreenColor,
    AussieColorData weatherScreenColor,
    AussieColorData naturalParksScreenColor,
    AussieColorData dykScreenColor,
  }) {
    var _modifiedModel = currentModel.copyWith(
      brightness: brightness,
      peopleScreenColor: peopleScreenColor,
      foodScreenColor: foodScreenColor,
      eventsScreenColor: placesScreenColor,
      placesScreenColor: placesScreenColor,
      entertainmentScreenColor: entertainmentScreenColor,
      faunaScreenColor: faunaScreenColor,
      floraScreenColor: floraScreenColor,
      teritoriesScreenColor: teritoriesScreenColor,
      weatherScreenColor: weatherScreenColor,
      naturalParksScreenColor: naturalParksScreenColor,
      dykScreenColor: dykScreenColor,
    );
    SharedPreferences.getInstance().then(
      (perfs) {
        perfs.setString("theme", _modifiedModel.toJson());
        emit(ThemeChanged(_modifiedModel));
      },
    );
  }

  void toggleBrightness() {
    final Brightness _currentBrightness = currentModel.brightness;
    if (_currentBrightness == Brightness.light) {
      changeTheme(
        brightness: Brightness.dark,
        peopleScreenColor: PeopleScreen.data.dark,
        placesScreenColor: PlacesScreen.data.dark,
        eventsScreenColor: EventsScreen.data.dark,
        foodScreenColor: FoodScreen.data.dark,
        entertainmentScreenColor: EntertainmentScreen.data.dark,
        faunaScreenColor: FaunaScreen.data.dark,
        floraScreenColor: FloraScreen.data.dark,
        teritoriesScreenColor: TeritoriesScreen.data.dark,
        weatherScreenColor: WeatherScreen.data.dark,
        naturalParksScreenColor: NaturalParksScreen.data.dark,
        dykScreenColor: DYKScreen.data.dark,
      );
    } else {
      changeTheme(
        brightness: Brightness.light,
        peopleScreenColor: PeopleScreen.data.light,
        placesScreenColor: PlacesScreen.data.light,
        eventsScreenColor: EventsScreen.data.light,
        foodScreenColor: FoodScreen.data.light,
        entertainmentScreenColor: EntertainmentScreen.data.light,
        faunaScreenColor: FaunaScreen.data.light,
        floraScreenColor: FloraScreen.data.light,
        teritoriesScreenColor: TeritoriesScreen.data.light,
        weatherScreenColor: WeatherScreen.data.light,
        naturalParksScreenColor: NaturalParksScreen.data.light,
        dykScreenColor: DYKScreen.data.light,
      );
    }
  }

  ThemeModel get currentModel => state.model;
}

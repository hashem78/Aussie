import 'package:aussie/models/info/natural_parks/natural_parks.dart';
import 'package:aussie/models/info/teritory/teritory.dart';
import 'package:aussie/presentation/screens/screen_data.dart';
import 'package:aussie/presentation/screens/usermanagement/initial.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/attendees/cubit/attendees_cubit.dart';
import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/state/paginated/cubit/paginated_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/state/themes/cubit/theme_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/state/weather/cubit/weather_cubit.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:aussie/localizations.dart';

import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/misc/settings.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';

import 'models/info/species/species.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();
  final _perfs = await SharedPreferences.getInstance();
  String brightnessString;
  Brightness brightness;
  if (_perfs.containsKey("brightness")) {
    brightnessString = _perfs.get("brightness") as String;
  } else {
    brightnessString = "light";
    _perfs.setString("brightness", brightnessString);
  }
  final bool isLight = brightnessString == 'light';
  brightness = isLight ? Brightness.light : Brightness.dark;

  SystemChrome.setEnabledSystemUIOverlays([]);
  Locale locale;
  if (_perfs.containsKey("lang")) {
    locale = Locale(_perfs.getString("lang"), '');
  } else {
    _perfs.setString("lang", "en");
    locale = const Locale('en', '');
  }
  runApp(MyApp(brightness, locale));
}

class MyApp extends StatelessWidget {
  final Brightness brightness;
  final Locale locale;

  const MyApp(this.brightness, this.locale)
      : assert(brightness != null && locale != null);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BrightnessCubit(brightness)),
        BlocProvider(create: (_) => LanguageCubit(locale)),
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => UserManagementCubit()),
        BlocProvider(create: (_) => MultiImagePickingCubit()),
        BlocProvider(create: (_) => SingleImagePickingCubit()),
        BlocProvider(create: (_) => WeatherCubit()),
        BlocProvider(create: (_) => AttendeesCubit()),
        BlocProvider(
          create: (_) => PaginatedCubit<NaturalParkModel>("naturalParks"),
        ),
        BlocProvider(
          create: (_) => PaginatedCubit<TeritoryModel>("teritories"),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<BrightnessCubit, Brightness>(
            builder: (context, state) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  Size size;
                  if (orientation == Orientation.portrait) {
                    size = const Size(1920, 1080);
                  } else {
                    size = const Size(1080, 1920);
                  }
                  return ScreenUtilInit(
                    designSize: size,
                    builder: () {
                      return MaterialApp(
                        locale: languageState.currentLocale,
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          AussieLocalizations.delegate,
                        ],
                        supportedLocales: const [
                          Locale('en', ''),
                          Locale('ar', ''),
                        ],
                        localeResolutionCallback: (locale, supportedLocales) {
                          if (supportedLocales.contains(locale)) return locale;
                          return supportedLocales.first;
                        },
                        home: BlocProvider(
                          create: (context) =>
                              UserManagementCubit()..isUserSignedIn(),
                          child: SafeArea(
                            child: InitialScreen(),
                          ),
                        ),
                        theme: ThemeData(
                          brightness: state,
                          pageTransitionsTheme: const PageTransitionsTheme(
                            builders: <TargetPlatform, PageTransitionsBuilder>{
                              TargetPlatform.android:
                                  ZoomPageTransitionsBuilder(),
                            },
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                            ),
                          ),
                        ),
                        routes: routes,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    AussieScreenData.naturalParksNavPath: (BuildContext context) =>
        const NaturalParksScreen(),
    AussieScreenData.weatherNavPath: (BuildContext context) =>
        const WeatherScreen(),
    AussieScreenData.territoriesNavPath: (BuildContext context) =>
        const TeritoriesScreen(),
    AussieScreenData.faunaNavPath: (BuildContext context) => BlocProvider(
          create: (context) => PaginatedCubit<SpeciesDetailsModel>("fauna"),
          child: FaunaScreen(),
        ),
    AussieScreenData.floraNavPath: (BuildContext context) => BlocProvider(
          create: (context) => PaginatedCubit<SpeciesDetailsModel>("flora"),
          child: FloraScreen(),
        ),
    AussieScreenData.settingsNavPath: (BuildContext context) =>
        SettingsScreen(),
  };
}

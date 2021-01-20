import 'dart:convert';

import 'package:aussie/presentation/screens/usermanagement/initial.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/state/weather/cubit/weather_cubit.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aussie/localizations.dart';
import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/misc/settings.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/state/themes/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();
  final _perfs = await SharedPreferences.getInstance();
  Map<String, dynamic> themeMap;
  if (_perfs.containsKey("theme")) {
    final String themeString = _perfs.get("theme") as String;
    themeMap = jsonDecode(themeString) as Map<String, dynamic>;
  } else {
    themeMap = ThemeModel.defaultThemeMap;
    _perfs.setString("theme", jsonEncode(themeMap));
  }
  Locale locale;
  if (_perfs.containsKey("lang")) {
    locale = Locale(_perfs.getString("lang"), '');
  } else {
    _perfs.setString("lang", "en");
    locale = const Locale('en', '');
  }
  runApp(MyApp(themeMap, locale));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> themeMap;
  final Locale locale;

  const MyApp(this.themeMap, this.locale)
      : assert(themeMap != null && locale != null);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Provider.value(
      value: LoadingBouncingGrid.square(
        backgroundColor: Colors.blue,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit(themeMap)),
          BlocProvider(create: (context) => LanguageCubit(locale)),
          BlocProvider(create: (context) => SignupBloc()),
          BlocProvider(create: (context) => UserManagementCubit()),
          BlocProvider(create: (_) => MultiImagePickingCubit()),
          BlocProvider(create: (_) => SingleImagePickingCubit()),
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, languageState) {
            return BlocBuilder<ThemeCubit, ThemeState>(
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
                      child: MaterialApp(
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
                          child: InitialScreen(),
                        ),
                        theme: ThemeData(
                          brightness: state.model.brightness,
                          outlinedButtonTheme: OutlinedButtonThemeData(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(15.0),
                              shape: const RoundedRectangleBorder(),
                            ),
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                            ),
                          ),
                        ),
                        routes: routes,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  static final routes = {
    NaturalParksScreen.data.navPath: (BuildContext context) =>
        NaturalParksScreen(),
    WeatherScreen.data.navPath: (BuildContext context) => BlocProvider(
          create: (context) => WeatherCubit(),
          child: WeatherScreen(),
        ),
    TeritoriesScreen.data.navPath: (BuildContext context) => TeritoriesScreen(),
    FaunaScreen.data.navPath: (BuildContext context) => FaunaScreen(),
    FloraScreen.data.navPath: (BuildContext context) => FloraScreen(),
    SettingsScreen.navPath: (BuildContext context) => SettingsScreen(),
  };
}

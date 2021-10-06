import 'aussie_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(
    MyApp(
      await onStartupBrightness(),
      await onStartupLocale(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeMode themeMode;

  final Locale locale;

  const MyApp(
    this.themeMode,
    this.locale, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ignore: always_specify_types
      providers: [
        BlocProvider<ThemeModeCubit>(
          create: (BuildContext context) => ThemeModeCubit(themeMode),
        ),
        BlocProvider<LanguageCubit>(
            create: (BuildContext context) => LanguageCubit(locale)),
        BlocProvider<UserManagementCubit>(
          create: (BuildContext context) => UserManagementCubit(),
        ),
        BlocProvider<WeatherCubit>(
          create: (BuildContext context) => WeatherCubit(),
        ),
        BlocProvider<AttendeesCubit>(
          create: (BuildContext context) => AttendeesCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (BuildContext context, LanguageState languageState) {
          return BlocBuilder<ThemeModeCubit, ThemeMode>(
            builder: (BuildContext context, ThemeMode themeState) {
              return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
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
                        // ignore: always_specify_types
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          AussieLocalizations.delegate,
                        ],
                        supportedLocales: const <Locale>[
                          Locale('en', ''),
                          Locale('ar', ''),
                        ],
                        localeResolutionCallback: (Locale? locale,
                            Iterable<Locale> supportedLocales) {
                          if (supportedLocales.contains(locale)) {
                            return locale;
                          }
                          return supportedLocales.first;
                        },
                        home: BlocProvider<UserManagementCubit>(
                          create: (BuildContext context) {
                            return UserManagementCubit()..isUserSignedIn();
                          },
                          child: const SafeArea(
                            child: InitialScreen(),
                          ),
                        ),
                        themeMode: themeState,
                        theme: ThemeData(
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

  static final Map<String, Widget Function(BuildContext)> routes =
      <String, Widget Function(BuildContext)>{
    AussieScreenData.naturalParksNavPath: (BuildContext context) {
      return BlocProvider<PaginatedCubit<NaturalParkModel>>(
        create: (BuildContext context) {
          return PaginatedCubit<NaturalParkModel>('natural_parks');
        },
        child: const NaturalParksScreen(),
      );
    },
    AussieScreenData.weatherNavPath: (BuildContext context) {
      return const WeatherScreen();
    },
    AussieScreenData.territoriesNavPath: (BuildContext context) {
      return BlocProvider<PaginatedCubit<TeritoryModel>>(
        create: (BuildContext context) {
          return PaginatedCubit<TeritoryModel>('teritories');
        },
        child: const TeritoriesScreen(),
      );
    },
    AussieScreenData.faunaNavPath: (BuildContext context) {
      return BlocProvider<PaginatedCubit<SpeciesDetailsModel>>(
        create: (BuildContext context) {
          return PaginatedCubit<SpeciesDetailsModel>('fauna');
        },
        child: const FaunaScreen(),
      );
    },
    AussieScreenData.floraNavPath: (BuildContext context) {
      return BlocProvider<PaginatedCubit<SpeciesDetailsModel>>(
        create: (BuildContext context) {
          return PaginatedCubit<SpeciesDetailsModel>('flora');
        },
        child: const FloraScreen(),
      );
    },
    AussieScreenData.settingsNavPath: (BuildContext context) {
      return const SettingsScreen();
    },
  };
}

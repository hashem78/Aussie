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
      providers: [
        BlocProvider(
          create: (BuildContext context) => ThemeModeCubit(themeMode),
        ),
        BlocProvider(create: (BuildContext context) => LanguageCubit(locale)),
        BlocProvider(create: (BuildContext context) => UserManagementCubit()),
        BlocProvider(create: (BuildContext context) => WeatherCubit()),
        BlocProvider(create: (BuildContext context) => AttendeesCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeModeCubit, ThemeMode>(
            builder: (context, themeState) {
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

  static final Map<String, Widget Function(BuildContext)> routes = {
    AussieScreenData.naturalParksNavPath: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) {
          return PaginatedCubit<NaturalParkModel>("natural_parks");
        },
        child: const NaturalParksScreen(),
      );
    },
    AussieScreenData.weatherNavPath: (BuildContext context) =>
        const WeatherScreen(),
    AussieScreenData.territoriesNavPath: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) {
          return PaginatedCubit<TeritoryModel>("teritories");
        },
        child: const TeritoriesScreen(),
      );
    },
    AussieScreenData.faunaNavPath: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) =>
            PaginatedCubit<SpeciesDetailsModel>("fauna"),
        child: const FaunaScreen(),
      );
    },
    AussieScreenData.floraNavPath: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) =>
            PaginatedCubit<SpeciesDetailsModel>("flora"),
        child: const FloraScreen(),
      );
    },
    AussieScreenData.settingsNavPath: (BuildContext context) =>
        const SettingsScreen(),
  };
}

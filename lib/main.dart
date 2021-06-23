import 'package:aussie/state/networking/cubit/networking_cubit.dart';

import 'aussie_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIOverlays([]);

  final NetworkingCubit networkingCubit = NetworkingCubit();
  // DataConnectionChecker().onStatusChange.listen(
  //   (DataConnectionStatus event) {
  //     if (event == DataConnectionStatus.connected) {
  //       networkingCubit.emitAvail();
  //     } else {
  //       networkingCubit.emitUnavail();
  //     }
  //   },
  // );
  runApp(
    BlocProvider.value(
      value: networkingCubit,
      child: MyApp(
        await onStartupBrightness(),
        await onStartupLocale(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AussieBrightness brightness;

  final Locale locale;

  const MyApp(this.brightness, this.locale);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => BrightnessCubit(
            brightness,
          ),
        ),
        BlocProvider(create: (BuildContext context) => LanguageCubit(locale)),
        BlocProvider(create: (BuildContext context) => UserManagementCubit()),
        BlocProvider(create: (BuildContext context) => WeatherCubit()),
        BlocProvider(create: (BuildContext context) => AttendeesCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<BrightnessCubit, AussieBrightness>(
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
                          brightness: state.asMaterialBrightness,
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
        child: FaunaScreen(),
      );
    },
    AussieScreenData.floraNavPath: (BuildContext context) {
      return BlocProvider(
        create: (BuildContext context) =>
            PaginatedCubit<SpeciesDetailsModel>("flora"),
        child: FloraScreen(),
      );
    },
    AussieScreenData.settingsNavPath: (BuildContext context) =>
        SettingsScreen(),
  };
}

import 'package:aussie/state/shared_prefrences.dart';
import 'package:aussie/state/theme_mode.dart';

import 'aussie_imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rv;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(
    rv.ProviderScope(
      overrides: <rv.Override>[
        sharedPrefrencesProvider.overrideWithValue(prefs),
      ],
      child: MyApp(
        await onStartupLocale(),
      ),
    ),
  );
}

class MyApp extends rv.ConsumerWidget {
  final Locale locale;

  const MyApp(
    this.locale, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, rv.WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) => LanguageCubit(locale),
        ),
        BlocProvider<UMCubit>(
          create: (BuildContext context) => UMCubit(),
        ),
        BlocProvider<AttendeesCubit>(
          create: (BuildContext context) => AttendeesCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (BuildContext context, LanguageState languageState) {
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
                    localeResolutionCallback:
                        (Locale? locale, Iterable<Locale> supportedLocales) {
                      if (supportedLocales.contains(locale)) {
                        return locale;
                      }
                      return supportedLocales.first;
                    },
                    home: BlocProvider<UMCubit>(
                      create: (BuildContext context) {
                        return UMCubit()..isUserSignedIn();
                      },
                      child: const SafeArea(
                        child: InitialScreen(),
                      ),
                    ),
                    themeMode: themeMode!.mode,
                    theme: ThemeData(
                      brightness: themeMode.brightness,
                      pageTransitionsTheme: const PageTransitionsTheme(
                        builders: <TargetPlatform, PageTransitionsBuilder>{
                          TargetPlatform.android: ZoomPageTransitionsBuilder(),
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
      ),
    );
  }

  static final routes = {
    ScreenData.settingsNavPath: (context) {
      return const SettingsScreen();
    },
  };
}

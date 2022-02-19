import 'package:aussie/providers/providers.dart';
import 'package:aussie/state/language.dart';
import 'package:aussie/state/shared_prefrences.dart';
import 'package:aussie/state/theme_mode.dart';

import 'aussie_imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rv;

import 'presentation/screens/feed/feed.dart';

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends rv.ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, rv.WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return BlocProvider(
      create: (context) => AttendeesCubit(),
      child: OrientationBuilder(
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
                locale: locale,
                debugShowCheckedModeBanner: false,
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
                localeResolutionCallback: (locale, supportedLocales) {
                  if (supportedLocales.contains(locale)) {
                    return locale;
                  }
                  return supportedLocales.first;
                },
                home: const SplashScreen(),
                themeMode: themeMode!.mode,
                theme: ThemeData(
                  brightness: themeMode.brightness,
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
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
      ),
    );
  }

  static final routes = {
    ScreenData.settingsNavPath: (_) => const SettingsScreen(),
  };
}

class SplashScreen extends rv.ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, rv.WidgetRef ref) {
    ref.listen<AussieUser>(
      localUserProvider,
      (previous, next) {
        print('new state is : $next');
        next.mapOrNull(
          signedIn: (val) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return rv.ProviderScope(
                    overrides: [
                      scopedUserProvider.overrideWithValue(next),
                    ],
                    child: const FeedScreen(),
                  );
                },
              ),
            );
          },
          signedOut: (val) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const InitialUserActionScreen();
                },
              ),
              (route) => !route.isFirst,
            );
          },
          firstRun: (user) {
            print('executing is first run');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return const InitialUserActionScreen();
                },
              ),
            );
          },
        );
      },
    );
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

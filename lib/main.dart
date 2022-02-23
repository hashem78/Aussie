import 'package:aussie/presentation/screens/splash_screen.dart';
import 'package:aussie/state/language.dart';
import 'package:aussie/state/shared_prefrences.dart';
import 'package:aussie/state/theme_mode.dart';

import 'aussie_imports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    ProviderScope(
      overrides: <Override>[
        sharedPrefrencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

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
    );
  }

  static final routes = {
    ScreenData.settingsNavPath: (_) => const SettingsScreen(),
  };
}

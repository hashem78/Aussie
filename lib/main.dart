import 'package:evento/localizations.dart';
import 'package:evento/presentation/screens/misc/settings.dart';
import 'package:evento/presentation/screens/screen_data.dart';
import 'package:evento/presentation/screens/splash_screen.dart';
import 'package:evento/state/language.dart';
import 'package:evento/state/shared_prefrences.dart';
import 'package:evento/state/theme_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();

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
              themeMode: themeMode.mode,
              theme: ThemeData(
                brightness: themeMode.brightness,
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  border: InputBorder.none,
                ),
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

import 'dart:math';
import 'package:aussie/aussie_imports.dart';

Color getRandomColor() {
  final _col = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  if (_col == Colors.amber) return Colors.lightBlue;

  return _col.shade700;
}

Widget? buildImage(
  String? imageUrl, {
  BoxFit fit = BoxFit.fill,
  bool showPlaceHolder = true,
  Duration fadeIn = const Duration(milliseconds: 500),
  ColorFilter? colorFilter,
}) {
  if (imageUrl == null) return null;
  if (imageUrl.contains(".svg")) {
    return SvgPicture.network(
      imageUrl,
      fit: fit,
    );
  } else if (imageUrl.isNotEmpty) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: colorFilter,
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholderFadeInDuration: Duration.zero,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  } else {
    return null;
  }
}

AussieUser getCurrentUser(BuildContext context) =>
    Provider.of<AussieUser>(context, listen: false);

String? getTranslation(BuildContext context, String? key) =>
    AussieLocalizations.of(context)!.translate(key);

SignupBloc getSignupBloc(BuildContext context) =>
    BlocProvider.of<SignupBloc>(context);

EventModel getEventModel(BuildContext context) =>
    Provider.of<EventModel>(context, listen: false);

Future<ThemeMode> onStartupBrightness() async {
  final _perfs = await SharedPreferences.getInstance();
  String? brightnessString;
  ThemeMode brightness;
  if (_perfs.containsKey("brightness")) {
    brightnessString = _perfs.getString("brightness");
  } else {
    brightnessString = "system";
    _perfs.setString("brightness", brightnessString);
  }
  if (brightnessString == 'system') {
    brightness = ThemeMode.system;
  } else if (brightnessString == 'light') {
    brightness = ThemeMode.light;
  } else {
    brightness = ThemeMode.dark;
  }
  return brightness;
}

Future<Locale> onStartupLocale() async {
  final _perfs = await SharedPreferences.getInstance();
  Locale locale;
  if (_perfs.containsKey("lang")) {
    locale = Locale(_perfs.getString("lang")!, '');
  } else {
    _perfs.setString("lang", "en");
    locale = const Locale('en', '');
  }
  return locale;
}

void toggleLanguage(BuildContext context, String currentLanguage) {
  if (currentLanguage == "ar") {
    BlocProvider.of<LanguageCubit>(context)
        .changeLocale(
          const Locale("en", ""),
        )
        .whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                getTranslation(context, "languageChangedText")!,
              ),
            ),
          ),
        );
  } else {
    BlocProvider.of<LanguageCubit>(context)
        .changeLocale(
          const Locale("ar", ""),
        )
        .whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                getTranslation(context, "languageChangedText")!,
              ),
            ),
          ),
        );
  }
}

import 'dart:math';
import 'package:aussie/aussie_imports.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart';

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

AussieBrightness getPlatformBrightness() {
  return SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
      ? const AussieBrightnessDark()
      : const AussieBrightnessLight();
}

Future<AussieBrightness> onStartupBrightness() async {
  final _perfs = await SharedPreferences.getInstance();
  String? brightnessString;
  AussieBrightness brightness;
  if (_perfs.containsKey("brightness")) {
    brightnessString = _perfs.getString("brightness");
  } else {
    brightnessString = "system";
    _perfs.setString("brightness", brightnessString);
  }
  if (brightnessString == 'system') {
    brightness = const AussieBrightnessSystem();
  } else if (brightnessString == 'light') {
    brightness = const AussieBrightnessLight();
  } else {
    brightness = const AussieBrightnessDark();
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

import 'dart:math';
import 'package:aussie/localizations.dart';
import 'package:aussie/state/language.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color getRandomColor() {
  final MaterialColor _col =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
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
  if (imageUrl.isNotEmpty) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (
        BuildContext context,
        ImageProvider<Object> imageProvider,
      ) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: colorFilter,
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholderFadeInDuration: Duration.zero,
      progressIndicatorBuilder: (
        BuildContext context,
        String url,
        DownloadProgress progress,
      ) {
        return Center(
          child: CircularProgressIndicator(
            value: progress.progress,
          ),
        );
      },
      errorWidget: (BuildContext context, String url, dynamic error) {
        return const Icon(Icons.error);
      },
    );
  } else {
    return null;
  }
}

String getTranslation(BuildContext context, String key) =>
    AussieLocalizations.of(context).translate(key);

Future<Locale> onStartupLocale() async {
  final _perfs = await SharedPreferences.getInstance();
  Locale locale;
  if (_perfs.containsKey('lang')) {
    locale = Locale(_perfs.getString('lang')!, '');
  } else {
    _perfs.setString('lang', 'en');
    locale = const Locale('en', '');
  }
  return locale;
}

void toggleLanguage(BuildContext context, WidgetRef ref) {
  final currentLanguage = ref.read(localeProvider).languageCode;
  if (currentLanguage == 'ar') {
    ref.read(localeProvider.notifier).changeTo(const Locale('en', ''));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          getTranslation(context, 'languageChangedText'),
        ),
      ),
    );
  } else {
    ref.read(localeProvider.notifier).changeTo(const Locale('ar', ''));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          getTranslation(context, 'languageChangedText'),
        ),
      ),
    );
  }
}

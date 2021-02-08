import 'dart:math';

import 'package:aussie/localizations.dart';

import 'package:aussie/models/event/event.dart';

import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Color getRandomColor() {
  final _col = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  if (_col == Colors.amber) return Colors.lightBlue;

  return _col.shade700;
}

Widget buildImage(
  String imageUrl, {
  BoxFit fit = BoxFit.fill,
  bool showPlaceHolder = true,
  Duration fadeIn = const Duration(milliseconds: 500),
  ColorFilter colorFilter,
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
      fadeInDuration: Duration.zero,
      placeholder: showPlaceHolder
          ? (context, url) => Container(
                color: Colors.lightBlueAccent,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          : null,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  } else {
    return null;
  }
}

PageTransitionType getAppropriateAnimation(BuildContext context) =>
    BlocProvider.of<LanguageCubit>(context).appropriateAnimation();

AussieUser getCurrentUser(BuildContext context) =>
    Provider.of<AussieUser>(context, listen: false);

String getTranslation(BuildContext context, String key) =>
    AussieLocalizations.of(context).translate(key);

SignupBloc getSignupBloc(BuildContext context) =>
    BlocProvider.of<SignupBloc>(context);

EventModel getEventModel(BuildContext context) =>
    Provider.of<EventModel>(context, listen: false);

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
                getTranslation(context, "languageChangedText"),
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
                getTranslation(context, "languageChangedText"),
              ),
            ),
          ),
        );
  }
}

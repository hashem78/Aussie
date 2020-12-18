import 'dart:math';

import 'package:aussie/localizations.dart';
import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/state/themes/cubit/theme_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Color getRandomColor() {
  var _col = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  if (_col == Colors.amber) return Colors.lightBlue;

  return _col.shade700;
}

Widget buildImage(
  String imageUrl, {
  BoxFit fit = BoxFit.fill,
  bool showPlaceHolder = true,
  Duration fadeInDuration = const Duration(milliseconds: 500),
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
      fadeInDuration: fadeInDuration,
      placeholder: showPlaceHolder
          ? (context, url) => Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: getIndicator(context),
                ),
              )
          : null,
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  } else {
    return null;
  }
}

LoadingBouncingGrid getIndicator(context) =>
    Provider.of<LoadingBouncingGrid>(context, listen: false);

PageTransitionType getAppropriateAnimation(BuildContext context) =>
    BlocProvider.of<LanguageCubit>(context).appropriateAnimation();

ThemeModel getCurrentThemeModel(BuildContext context) =>
    BlocProvider.of<ThemeCubit>(context, listen: true).currentModel;

AussieUser getCurrentUser(BuildContext context) =>
    Provider.of<AussieUser>(context, listen: false);

String getTranslation(BuildContext context, String key) =>
    AussieLocalizations.of(context).translate(key);
AussieColorData getColorData(BuildContext context) =>
    Provider.of<AussieColorData>(context, listen: false);

SignupBloc getSignupBloc(BuildContext context) =>
    BlocProvider.of<SignupBloc>(context);

EventModel getEventModel(BuildContext context) =>
    Provider.of<EventModel>(context, listen: false);

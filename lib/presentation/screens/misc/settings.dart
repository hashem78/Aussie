import 'package:aussie/presentation/screens/misc/widgets/about_aussie_tile.dart';
import 'package:aussie/presentation/screens/misc/widgets/brightness_tile.dart';
import 'package:aussie/presentation/screens/misc/widgets/language_tile.dart';
import 'package:aussie/presentation/screens/misc/widgets/settings_appbar.dart';
import 'package:aussie/presentation/screens/misc/widgets/signout_tile.dart';
import 'package:aussie/presentation/screens/screen_data.dart';

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SettingsAppbar(tTitle: AussieScreenData.settingsTitle),
            SliverList(
              delegate: SliverChildListDelegate(
                const <Widget>[
                  BrightnessTile(),
                  AboutAussieTile(),
                  LanguageTile(),
                  SignoutTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

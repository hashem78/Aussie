import 'package:aussie/presentation/screens/misc/widgets/about_aussie_tile.dart';
import 'package:aussie/presentation/screens/misc/widgets/brightness_switch.dart';
import 'package:aussie/presentation/screens/misc/widgets/language_tile.dart';
import 'package:aussie/presentation/screens/misc/widgets/setting_appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static String navPath = "/settings";
  static String svgName = "settings.svg";
  static String tTitle = "settingsTitle";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SettingsAppbar(tTitle: tTitle),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BrightnessSwitch(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: AboutAussieTile(),
                ),
                LanguageTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

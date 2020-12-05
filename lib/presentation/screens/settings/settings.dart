import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/state/themes/cubit/theme_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  static String navPath = "/settings";
  static String svgName = "settings.svg";
  static String title = "settingsTitle";

  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: .5.sh,
            title: Text("Aussie"),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        getTranslation(context, title),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 200.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BrightnessSwitch(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(5),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationVersion: "1.0",
                        applicationName: "Aussie",
                        applicationLegalese:
                            getTranslation(context, "legalese"),
                      );
                    },
                    leading: Text(getTranslation(context, "aboutAussieText")),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.info),
                    ),
                  ),
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

class BrightnessSwitch extends StatefulWidget {
  @override
  _BrightnessSwitchState createState() => _BrightnessSwitchState();
}

class _BrightnessSwitchState extends State<BrightnessSwitch> {
  bool _isDark = false;
  @override
  void initState() {
    super.initState();
    _isDark = BlocProvider.of<ThemeCubit>(context).currentModel.brightness ==
        Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ListTile(
        contentPadding: EdgeInsets.all(5.0),
        leading: Text(getTranslation(context, "darkmodeText")),
        trailing: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Switch(
              value: _isDark,
              onChanged: (val) {
                _isDark = val;
                BlocProvider.of<ThemeCubit>(context).toggleBrightness();
              },
            );
          },
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        var _currentLanguage = state.currentLocale.languageCode;
        return ListTile(
          title: Text(getTranslation(context, "languageTitle")),
          subtitle: Text(
              "${state.currentLocale.languageCode == "ar" ? "العربية" : "English"}"),
          onTap: () {
            if (_currentLanguage == "ar") {
              BlocProvider.of<LanguageCubit>(context)
                  .changeLocale(
                    Locale("en", ""),
                  )
                  .whenComplete(
                    () => Scaffold.of(context).showSnackBar(
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
                    Locale("ar", ""),
                  )
                  .whenComplete(
                    () => Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          getTranslation(context, "languageChangedText"),
                        ),
                      ),
                    ),
                  );
            }
          },
        );
      },
    );
  }
}

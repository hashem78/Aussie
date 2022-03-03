import 'package:evento/constants.dart';
import 'package:evento/models/theme_mode/theme_mode.dart';
import 'package:evento/state/theme_mode.dart';
import 'package:evento/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrightnessTile extends ConsumerWidget {
  const BrightnessTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeModeProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ListTile(
        title: Text(getTranslation(context, 'brightnessTitle')),
        subtitle: Text(
          getTranslation(
            context,
            themeState.translationKey,
          ),
        ),
        contentPadding: const EdgeInsets.all(5.0),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const ChangeThemeDialog(),
          );
        },
      ),
    );
  }
}

class ChangeThemeDialog extends ConsumerWidget {
  const ChangeThemeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeModeProvider);
    return Dialog(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          RadioListTile<AThemeMode>(
            value: () {
              final systemBrightness =
                  SchedulerBinding.instance!.window.platformBrightness;
              if (systemBrightness == Brightness.dark) {
                return const AThemeMode.system(
                  mode: ThemeMode.dark,
                  brightness: Brightness.dark,
                );
              } else {
                return const AThemeMode.system(
                  mode: ThemeMode.light,
                  brightness: Brightness.light,
                );
              }
            }.call(),
            groupValue: themeState,
            title: Text(
              getTranslation(context, 'brightnessSystemTitle'),
            ),
            onChanged: (themeMode) =>
                ref.read(themeModeProvider.notifier).changeTo(
                      themeMode!,
                    ),
          ),
          RadioListTile<AThemeMode>(
            value: kLightMode,
            groupValue: themeState,
            title: Text(getTranslation(context, 'brightnessLightTitle')),
            onChanged: (themeMode) =>
                ref.read(themeModeProvider.notifier).changeTo(
                      themeMode!,
                    ),
          ),
          RadioListTile<AThemeMode>(
            value: kDarkMode,
            groupValue: themeState,
            title: Text(
              getTranslation(context, 'brightnessDarkTitle'),
            ),
            onChanged: (themeMode) =>
                ref.read(themeModeProvider.notifier).changeTo(
                      themeMode!,
                    ),
          ),
        ],
      ),
    );
  }
}

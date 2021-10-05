import 'package:aussie/aussie_imports.dart';

class BrightnessTile extends StatelessWidget {
  const BrightnessTile({Key? key}) : super(key: key);

  String getThemeModeAsString(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      return 'brightnessSystemTitle';
    } else if (themeMode == ThemeMode.dark) {
      return 'brightnessDarkTitle';
    } else {
      return 'brightnessLightTitle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ListTile(
        title: Text(getTranslation(context, 'brightnessTitle')),
        subtitle: Text(
          getTranslation(
            context,
            getThemeModeAsString(context.watch<ThemeModeCubit>().state),
          ),
        ),
        contentPadding: const EdgeInsets.all(5.0),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              final ThemeMode currentSetting =
                  context.watch<ThemeModeCubit>().state;
              return Dialog(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.system,
                      groupValue: currentSetting,
                      title: Text(
                        getTranslation(context, 'brightnessSystemTitle'),
                      ),
                      onChanged: (val) {
                        context.read<ThemeModeCubit>().changeToSystem();
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.light,
                      groupValue: currentSetting,
                      title:
                          Text(getTranslation(context, 'brightnessLightTitle')),
                      onChanged: (val) {
                        context.read<ThemeModeCubit>().changeToLight();
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.dark,
                      groupValue: currentSetting,
                      title: Text(
                        getTranslation(context, 'brightnessDarkTitle'),
                      ),
                      onChanged: (val) {
                        context.read<ThemeModeCubit>().changeToDark();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

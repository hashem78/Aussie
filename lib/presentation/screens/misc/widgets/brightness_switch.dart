import 'package:aussie/state/themes/cubit/theme_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        contentPadding: const EdgeInsets.all(5.0),
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

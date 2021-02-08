import 'package:aussie/state/themes/cubit/theme_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrightnessTile extends StatefulWidget {
  const BrightnessTile();
  @override
  _BrightnessTileState createState() => _BrightnessTileState();
}

class _BrightnessTileState extends State<BrightnessTile> {
  bool _isDark = false;
  @override
  void initState() {
    super.initState();
    _isDark = BlocProvider.of<BrightnessCubit>(context).currentBrightness ==
        Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5.0),
        leading: Text(getTranslation(context, "darkmodeText")),
        trailing: BlocBuilder<BrightnessCubit, Brightness>(
          builder: (context, state) {
            return Switch(
              value: _isDark,
              onChanged: (val) {
                _isDark = val;
                BlocProvider.of<BrightnessCubit>(context).toggleBrightness();
              },
            );
          },
        ),
      ),
    );
  }
}

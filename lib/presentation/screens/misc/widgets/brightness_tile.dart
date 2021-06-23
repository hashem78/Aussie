import 'package:aussie/aussie_imports.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BrightnessTile extends StatelessWidget {
  const BrightnessTile();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ListTile(
        title: Text(getTranslation(context, 'brightnessTitle')!),
        subtitle: Text(
          getTranslation(
            context,
            context.watch<BrightnessCubit>().currentBrightnessString,
          )!,
        ),
        contentPadding: const EdgeInsets.all(5.0),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              final AussieBrightness currentSetting =
                  context.watch<BrightnessCubit>().currentBrightness;
              return Dialog(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RadioListTile<AussieBrightness>(
                      value: const AussieBrightnessSystem(),
                      groupValue: currentSetting,
                      title: Text(
                          getTranslation(context, 'brightnessSystemTitle')!),
                      onChanged: (val) {
                        context.read<BrightnessCubit>().changeToSystem();
                      },
                    ),
                    RadioListTile<AussieBrightness>(
                      value: const AussieBrightnessLight(),
                      groupValue: currentSetting,
                      title: Text(
                          getTranslation(context, 'brightnessLightTitle')!),
                      onChanged: (val) {
                        context.read<BrightnessCubit>().changeToLight();
                      },
                    ),
                    RadioListTile<AussieBrightness>(
                      value: const AussieBrightnessDark(),
                      groupValue: currentSetting,
                      title:
                          Text(getTranslation(context, 'brightnessDarkTitle')!),
                      onChanged: (val) {
                        context.read<BrightnessCubit>().changeToDark();
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

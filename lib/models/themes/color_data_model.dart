import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:aussie/state/brightness/cubit/brightness_cubit.dart';

class AussieScreenColorData {
  static const AussieColor faunaDark = DarkAussieColor(
    Color(0xFF5D4037),
    Color(0xFF6D4C41),
  );
  static const AussieColor faunaLight = LightAussieColor(
    Color(0xFF8D6E63),
    Color(0xFFA1887F),
  );
  static const AussieColor naturalParksDark = DarkAussieColor(
    Color(0xFF0D47A1),
    Color(0xFF1565C0),
  );
  static const AussieColor naturalParksLight = LightAussieColor(
    Color(0xFF0D47A1),
    Color(0xFF1565C0),
  );
  static const AussieColor territoreisDark = DarkAussieColor(
    Color(0xFF5D4037),
    Color(0xFF4E342E),
  );
  static const AussieColor territoriesLight = LightAussieColor(
    Colors.brown,
    Color(0xFF8D6E63),
  );
  static const AussieColor weatherDark = DarkAussieColor(
    Color(0xFF0288D1),
    Color(0xFF039BE5),
  );
  static const AussieColor weatherLight = LightAussieColor(
    Color(0xFF29B6F6),
    Color(0xFF4FC3F7),
  );
  static const AussieColor floraLight = LightAussieColor(
    Color(0xFF66BB6A),
    Color(0xFF81C784),
  );
  static const AussieColor floraDark = DarkAussieColor(
    Color(0xFF388E3C),
    Color(0xFF43A047),
  );
}

abstract class AussieColor {
  final Color swatchColor;
  final Color backgroundColor;

  const AussieColor({
    @required this.swatchColor,
    @required this.backgroundColor,
  }) : assert(swatchColor != null && backgroundColor != null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AussieColor &&
        o.swatchColor == swatchColor &&
        o.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode => swatchColor.hashCode ^ backgroundColor.hashCode;
}

class DarkAussieColor extends AussieColor {
  const DarkAussieColor(
    Color swatchColor,
    Color backgroundColor,
  ) : super(swatchColor: swatchColor, backgroundColor: backgroundColor);
}

class LightAussieColor extends AussieColor {
  const LightAussieColor(
    Color swatchColor,
    Color backgroundColor,
  ) : super(swatchColor: swatchColor, backgroundColor: backgroundColor);
}

class AussieThemeBuilder extends StatelessWidget {
  final AussieColor dark;
  final AussieColor light;
  final Widget Function(
    BuildContext context,
    AussieColor color,
  ) builder;

  const AussieThemeBuilder({
    @required this.dark,
    @required this.light,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, AussieBrightness>(
      builder: (context, state) {
        if (state.asMaterialBrightness == Brightness.light) {
          return AussieThemeProvider(
            color: light,
            child: Builder(
              builder: (context) {
                return builder(context, light);
              },
            ),
          );
        } else {
          return AussieThemeProvider(
            color: dark,
            child: Builder(
              builder: (context) {
                return builder(context, dark);
              },
            ),
          );
        }
      },
    );
  }
}

class AussieThemeProvider extends InheritedWidget {
  final AussieColor color;

  const AussieThemeProvider({@required Widget child, @required this.color})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant AussieThemeProvider oldWidget) =>
      color == oldWidget.color;

  static AussieThemeProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AussieThemeProvider>();
}

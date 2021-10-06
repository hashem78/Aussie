import 'package:aussie/aussie_imports.dart';

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
    required this.swatchColor,
    required this.backgroundColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AussieColor &&
        other.swatchColor == swatchColor &&
        other.backgroundColor == backgroundColor;
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
    Key? key,
    required this.dark,
    required this.light,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (BuildContext context, ThemeMode state) {
        if (state == ThemeMode.light) {
          return AussieThemeProvider(
            color: light,
            child: Builder(
              builder: (BuildContext context) {
                return builder(context, light);
              },
            ),
          );
        } else {
          return AussieThemeProvider(
            color: dark,
            child: Builder(
              builder: (BuildContext context) {
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

  const AussieThemeProvider({
    Key? key,
    required Widget child,
    required this.color,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant AussieThemeProvider oldWidget) =>
      color == oldWidget.color;

  static AussieThemeProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AussieThemeProvider>();
}

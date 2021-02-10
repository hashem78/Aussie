part of 'brightness_cubit.dart';

abstract class AussieBrightness {
  const AussieBrightness();
}

class AussieBrightnessDark extends AussieBrightness {
  const AussieBrightnessDark();
}

class AussieBrightnessLight extends AussieBrightness {
  const AussieBrightnessLight();
}

class AussieBrightnessSystem extends AussieBrightness {
  const AussieBrightnessSystem();
}

extension AussieBrightnessExtension on AussieBrightness {
  Brightness get asMaterialBrightness {
    Brightness brightness;
    if (this is AussieBrightnessSystem) {
      brightness = SchedulerBinding.instance.window.platformBrightness;
    } else if (this is AussieBrightnessLight) {
      brightness = Brightness.light;
    } else {
      brightness = Brightness.dark;
    }

    return brightness;
  }

  String get string {
    String brightness;
    if (this is AussieBrightnessSystem) {
      brightness = 'System';
    } else if (this is AussieBrightnessLight) {
      brightness = 'Light';
    } else {
      brightness = 'Dark';
    }

    return brightness;
  }
}

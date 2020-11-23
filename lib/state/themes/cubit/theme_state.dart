part of 'theme_cubit.dart';

@immutable
abstract class ThemeState extends Equatable {
  const ThemeState(this.model);
  final ThemeModel model;
  @override
  List<Object> get props => [model];
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(ThemeModel model) : super(model);
}

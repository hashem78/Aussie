part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  final Locale currentLocale;
  const LanguageState(this.currentLocale);

  @override
  List<Object> get props => [currentLocale.languageCode];
}

class LanguageInitial extends LanguageState {
  LanguageInitial(Locale currentLocale) : super(currentLocale);
}

class LanguageChanged extends LanguageState {
  LanguageChanged(Locale currentLocale) : super(currentLocale);
}

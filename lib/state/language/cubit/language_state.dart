part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  final Locale currentLocale;
  const LanguageState(this.currentLocale);

  @override
  List<Object> get props => [currentLocale.languageCode];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(Locale currentLocale) : super(currentLocale);
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(Locale currentLocale) : super(currentLocale);
}

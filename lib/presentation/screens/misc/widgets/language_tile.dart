import 'package:aussie/aussie_imports.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final _currentLanguage = state.currentLocale.languageCode;
        return ListTile(
          title: Text(getTranslation(context, "languageTitle")!),
          subtitle: Text(
            state.currentLocale.languageCode == "ar" ? "العربية" : "English",
          ),
          onTap: () {
            toggleLanguage(context, _currentLanguage);
          },
        );
      },
    );
  }
}

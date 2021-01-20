import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final _currentLanguage = state.currentLocale.languageCode;
        return ListTile(
          title: Text(getTranslation(context, "languageTitle")),
          subtitle: Text(
            state.currentLocale.languageCode == "ar" ? "العربية" : "English",
          ),
          onTap: () {
            if (_currentLanguage == "ar") {
              BlocProvider.of<LanguageCubit>(context)
                  .changeLocale(
                    const Locale("en", ""),
                  )
                  .whenComplete(
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          getTranslation(context, "languageChangedText"),
                        ),
                      ),
                    ),
                  );
            } else {
              BlocProvider.of<LanguageCubit>(context)
                  .changeLocale(
                    const Locale("ar", ""),
                  )
                  .whenComplete(
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          getTranslation(context, "languageChangedText"),
                        ),
                      ),
                    ),
                  );
            }
          },
        );
      },
    );
  }
}

import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        var _currentLanguage = state.currentLocale.languageCode;
        return ListTile(
          title: Text(getTranslation(context, "languageTitle")),
          subtitle: Text(
              "${state.currentLocale.languageCode == "ar" ? "العربية" : "English"}"),
          onTap: () {
            if (_currentLanguage == "ar") {
              BlocProvider.of<LanguageCubit>(context)
                  .changeLocale(
                    Locale("en", ""),
                  )
                  .whenComplete(
                    () => Scaffold.of(context).showSnackBar(
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
                    Locale("ar", ""),
                  )
                  .whenComplete(
                    () => Scaffold.of(context).showSnackBar(
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

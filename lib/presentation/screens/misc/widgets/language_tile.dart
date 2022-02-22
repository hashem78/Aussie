import 'package:aussie/aussie_imports.dart';
import 'package:aussie/state/language.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageTile extends ConsumerWidget {
  const LanguageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return ListTile(
      title: Text(
        getTranslation(context, 'languageTitle'),
      ),
      subtitle: Text(
        currentLocale.languageCode == 'ar' ? 'العربية' : 'English',
      ),
      onTap: () {
        toggleLanguage(context, ref);
      },
    );
  }
}

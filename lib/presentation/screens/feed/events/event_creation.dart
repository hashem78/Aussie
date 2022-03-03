import 'package:evento/presentation/screens/feed/events/widgets/form/event_creation_form.dart';
import 'package:evento/state/theme_mode.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCreationScreen extends ConsumerWidget {
  const EventCreationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final correctColor = theme.map(
      dark: (t) => Colors.white,
      light: (t) => Colors.black.withOpacity(0.5),
      system: (t) {
        return t.brightness == Brightness.dark
            ? Colors.white
            : Colors.black.withOpacity(0.5);
      },
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: correctColor,
          ),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          title: Text(
            'New Event',
            style: TextStyle(
              fontSize: 100.sp,
              color: correctColor,
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: EventCreationForm(),
        ),
      ),
    );
  }
}

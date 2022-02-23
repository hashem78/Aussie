import 'package:aussie/presentation/screens/feed/events/event_creation.dart';

import 'package:aussie/state/theme_mode.dart';
import 'package:aussie/state/user_management.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animations/animations.dart';

class AnimatedAddEventFAB extends ConsumerWidget {
  const AnimatedAddEventFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider)!;
    final user = ref.watch(scopedUserProvider);
    late final Color color;

    if (themeMode.brightness == Brightness.light) {
      color = Colors.blue;
    } else {
      color = Colors.white;
    }

    return OpenContainer(
      closedShape: const RoundedRectangleBorder(),
      closedColor: color,
      openElevation: 0,
      openShape: const RoundedRectangleBorder(),
      closedBuilder: (BuildContext context, VoidCallback action) {
        return _AddEventFAB(color: color, action: action);
      },
      openBuilder: (BuildContext context, VoidCallback action) {
        return ProviderScope(
          overrides: [scopedUserProvider.overrideWithValue(user)],
          child: const EventCreationScreen(),
        );
      },
    );
  }
}

class _AddEventFAB extends StatelessWidget {
  final void Function() action;
  const _AddEventFAB({
    Key? key,
    required this.color,
    required this.action,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: FloatingActionButton(
        onPressed: action,
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        backgroundColor: color,
        child: Center(
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Icon(Icons.add, size: 20),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  getTranslation(
                    context,
                    'eventCreationFabTitle',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

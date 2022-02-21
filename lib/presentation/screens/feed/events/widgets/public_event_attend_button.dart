import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/state/event_management.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PublicAttendButton extends HookConsumerWidget {
  const PublicAttendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);
    final user = ref.watch(localUserProvider);

    final isUserAttending = useValueNotifier(user.mapOrNull(
      signedIn: (u) => u.attends!.contains(e.eventId),
    )!);
    Widget child;
    if (!useValueListenable(isUserAttending)) {
      child = TextButton(
        onPressed: () async {
          final state = await AttendeesRepository.makeUserWithIdAttendEvent(
            user.mapOrNull(signedIn: (value) => value.uid)!,
            e.eventId,
          );
          state.whenOrNull(
            attended: () {
              isUserAttending.value = true;
            },
          );
        },
        child: Text(
          getTranslation(context, 'attendButtonTextNormal'),
        ),
      );
    } else {
      child = Row(
        children: [
          Text(
            getTranslation(context, 'attendButtonTextAttending'),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () async {
              final state =
                  await AttendeesRepository.makeUserWithIdUnAttendEvent(
                user.mapOrNull(signedIn: (value) => value.uid)!,
                e.eventId,
              );
              state.whenOrNull(
                unattended: () {
                  isUserAttending.value = false;
                },
              );
            },
            child: const Text('Unattend'),
          ),
        ],
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}

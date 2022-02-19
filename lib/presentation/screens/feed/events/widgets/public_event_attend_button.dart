import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PublicAttendButton extends ConsumerWidget {
  const PublicAttendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final EventModel e = getEventModel(context);
    final user = ref.read(localUserProvider);

    return BlocBuilder<AttendeesCubit, AttendeesState>(
      builder: (BuildContext context, AttendeesState state) {
        print(state);
        Widget child;
        if (state is AttendeesInitial) {
          child = TextButton(
            onPressed: () {
              context
                  .read<AttendeesCubit>()
                  .makeUserWithIdAttendEvent(user.mapOrNull(signedIn: (value) => value.uid)!, e.eventId);
            },
            child: Text(
              getTranslation(context, 'attendButtonTextNormal'),
            ),
          );
        } else if (state is AttendeesPerformingAction) {
          child = TextButton(
            onPressed: null,
            child: Row(
              children: <Widget>[
                const Center(child: CircularProgressIndicator()),
                Text(
                  getTranslation(context, 'attendButtonTextAttempting'),
                ),
              ],
            ),
          );
        } else if (state is AttendeesAttended) {
          child = TextButton(
            onPressed: null,
            child: Text(
              getTranslation(context, 'attendButtonTextAttending'),
            ),
          );
        } else {
          child = TextButton(
            onPressed: null,
            child: Text(
              getTranslation(context, 'attendButtonTextError'),
            ),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
    );
  }
}

import 'package:aussie/aussie_imports.dart';

class PublicAttendButton extends StatelessWidget {
  const PublicAttendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    final AussieUser currentUser = getCurrentUser(context);

    return BlocBuilder<UMCubit, UMCState>(
      builder: (BuildContext context, UMCState state) {
        Widget child;
        if (state is UMCInitial) {
          child = TextButton(
            onPressed: () {
              context
                  .read<UMCubit>()
                  .makeUserWithIdAttendEvent(currentUser, e.eventId);
            },
            child: Text(
              getTranslation(context, 'attendButtonTextNormal'),
            ),
          );
        } else if (state is UMCPerformingAction) {
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
        } else if (state is UMCAttended) {
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

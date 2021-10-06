import 'package:aussie/aussie_imports.dart';

class PublicAttendButton extends StatelessWidget {
  const PublicAttendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    final AussieUser currentUser = getCurrentUser(context);

    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (BuildContext context, UserManagementState state) {
        Widget child;
        if (state is UserManagementInitial) {
          child = TextButton(
            onPressed: () {
              context
                  .read<UserManagementCubit>()
                  .makeUserWithIdAttendEvent(currentUser, e.eventId);
            },
            child: Text(
              getTranslation(context, 'attendButtonTextNormal'),
            ),
          );
        } else if (state is UserManagementPerformingAction) {
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
        } else if (state is UserManagementAttended) {
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

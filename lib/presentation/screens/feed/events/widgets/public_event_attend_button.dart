import 'package:aussie/models/event/event.dart';
import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicAttendButton extends StatelessWidget {
  const PublicAttendButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventModel e = getEventModel(context);
    final AussieUser currentUser = getCurrentUser(context);

    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        if (state is UserManagementInitial) {
          return TextButton(
            onPressed: () {
              context
                  .read<UserManagementCubit>()
                  .makeUserWithIdAttendEvent(currentUser, e.eventId);
            },
            child: Text(getTranslation(context, "attendButtonTextNormal")),
          );
        } else if (state is UserManagementPerformingAction) {
          return TextButton(
            onPressed: null,
            child: Row(
              children: [
                Center(child: getIndicator(context)),
                Text(getTranslation(context, "attendButtonTextAttempting")),
              ],
            ),
          );
        } else if (state is UserManagementAttended) {
          return TextButton(
            onPressed: null,
            child: Text(getTranslation(context, "attendButtonTextAttending")),
          );
        } else {
          return TextButton(
              onPressed: null,
              child: Text(getTranslation(context, "attendButtonTextError")));
        }
      },
    );
  }
}

import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement_cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        if (state is UserManagementSignOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) {
                return InitialUserActionScreen();
              },
            ),
            (route) => false,
          );
        }
      },
      child: ListTile(
        onTap: () {
          context.read<UserManagementCubit>().signout();
        },
        leading: const Icon(Icons.unsubscribe),
        title: Text(getTranslation(context, "signoutTileTitle")!),
      ),
    );
  }
}

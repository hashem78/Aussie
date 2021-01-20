import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        if (state is UserManagementSignOut) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return InitialUserActionScreen();
              },
            ),
          );
        }
      },
      child: ListTile(
        onTap: () {
          context.read<UserManagementCubit>().signout();
        },
        leading: const Icon(Icons.unsubscribe),
        title: const Text("Signout"),
      ),
    );
  }
}

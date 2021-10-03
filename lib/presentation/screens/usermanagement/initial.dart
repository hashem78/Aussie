import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement_cubit/usermanagement_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        if (state is UserManagementSignin) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => UserManagementCubit()..getUserData(),
                  child: const FeedScreen(),
                );
              },
            ),
          );
        } else if (state is UserManagementNeedsAction) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const InitialUserActionScreen();
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

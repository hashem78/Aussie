import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is UserManagementSignin) {
            // print("in inital screen ${state.runtimeType}");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => UserManagementCubit()..getUserData(),
                    child: FeedScreen(),
                  );
                },
              ),
            );
          } else if (state is UserManagementNeedsAction) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return InitialUserActionScreen();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

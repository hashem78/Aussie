import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  final UserManagementCubit cubit = UserManagementCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<UserManagementCubit, UserManagementState>(
          buildWhen: (previous, current) {
            if (current is UserManagementInitial ||
                previous is UserManagementInitial) {
              return false;
            } else if (current is UserManagementSignin ||
                previous is UserManagementSignin) {
              return true;
            } else if (current is UserManagementNeedsAction ||
                previous is UserManagementNeedsAction) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            print("builder: ${state.runtimeType}");
            if (state is UserManagementInitial) {
              cubit.isUserSignedIn();
              return Container();
            } else if (state is UserManagementSignin) {
              return FeedScreen();
            } else if (state is UserManagementNeedsAction) {
              return InitialUserActionScreen();
            }
            print("stuck in builder in initial.dart");
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

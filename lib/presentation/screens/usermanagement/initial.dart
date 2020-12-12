import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final UserManagementCubit cubit = UserManagementCubit();
  @override
  void initState() {
    super.initState();
    cubit.isUserSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        cubit: cubit,
        builder: (context, state) {
          if (state is UserManagementSignin) {
            return FeedScreen();
          } else if (state is UserManagementNeedsAction) {
            return BlocProvider.value(
              value: cubit,
              child: InitialUserActionScreen(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

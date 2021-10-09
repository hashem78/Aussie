import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/initial_actions.dart';
import 'package:aussie/state/usermanagement_cubit/usermanagement_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UMCubit, UMCState>(
      listener: (BuildContext context, UMCState state) {
        if (state is UMCSignin) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<FeedScreen>(
              builder: (BuildContext context) {
                return BlocProvider<UMCubit>(
                  create: (BuildContext context) {
                    return UMCubit()..getUserData();
                  },
                  child: const FeedScreen(),
                );
              },
            ),
          );
        } else if (state is UMCNeedsAction) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<InitialUserActionScreen>(
              builder: (BuildContext context) {
                return const InitialUserActionScreen();
              },
            ),
          );
        }
      },
      builder: (BuildContext context, UMCState state) {
        return const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

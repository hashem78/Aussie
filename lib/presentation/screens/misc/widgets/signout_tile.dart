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
    return BlocListener<UMCubit, UMCState>(
      listener: (BuildContext context, UMCState state) {
        if (state is UMCSignOut) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<InitialUserActionScreen>(
              builder: (BuildContext context) {
                return const InitialUserActionScreen();
              },
            ),
            // ignore: always_specify_types
            (Route route) => false,
          );
        }
      },
      child: ListTile(
        onTap: () {
          context.read<UMCubit>().signout();
        },
        leading: const Icon(Icons.unsubscribe),
        title: Text(
          getTranslation(context, 'signoutTileTitle'),
        ),
      ),
    );
  }
}

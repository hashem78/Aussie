import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';

class CardOwner extends StatelessWidget {
  final double size;

  CardOwner({
    Key key,
    double size,
  })  : size = size ?? .1.sw,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        Widget child;

        if (state is UserMangementHasUserData) {
          child = InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfileScreen();
                  },
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: size,
                  height: size,
                  margin: const EdgeInsets.all(5),
                  child: Ink.image(
                    image: CachedNetworkImageProvider(
                      state.user.profilePictureLink,
                    ),
                  ),
                ),
                SizedBox(width: .05.sw),
                Text(
                  state.user.username,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          );
        } else {
          child = Container();
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: child,
        );
      },
    );
  }
}

class PublicCardOwner extends StatelessWidget {
  final double size;

  PublicCardOwner({
    Key key,
    double size,
  })  : size = size ?? .1.sw,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        print("=====public card owner=======");
        print(state);
        Widget child;

        if (state is UserMangementHasUserData) {
          child = InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => UserManagementCubit()
                        ..getUserDataFromUid(state.user.uid),
                      child: UserProfileScreen(),
                    );
                  },
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: size,
                  height: size,
                  margin: const EdgeInsets.all(5),
                  child: Ink.image(
                    image: CachedNetworkImageProvider(
                      state.user.profilePictureLink,
                    ),
                  ),
                ),
                SizedBox(width: .05.sw),
                Text(
                  state.user.username,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          );
        } else {
          child = Container();
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: child,
        );
      },
    );
  }
}

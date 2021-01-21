import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class CardOwner extends StatefulWidget {
  const CardOwner({
    Key key,
  }) : super(key: key);

  @override
  _CardOwnerState createState() => _CardOwnerState();
}

class _CardOwnerState extends State<CardOwner>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        Widget child;
        if (state is UserMangementHasUserData) {
          child = InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: BlocProvider(
                    create: (context) => UserManagementCubit()
                      ..getUserDataFromUid(state.user.uid),
                    child: const UserProfileScreen(),
                  ),
                  type: getAppropriateAnimation(context),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(5),
                  child: Ink.image(
                    fit: BoxFit.scaleDown,
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
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          vsync: this,
          child: child,
        );
      },
    );
  }
}

class PublicCardOwner extends StatefulWidget {
  final double size;

  const PublicCardOwner({Key key, this.size}) : super(key: key);

  @override
  _PublicCardOwnerState createState() => _PublicCardOwnerState();
}

class _PublicCardOwnerState extends State<PublicCardOwner>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        Widget child;

        if (state is UserMangementHasUserData) {
          child = InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: BlocProvider(
                    create: (context) => UserManagementCubit()
                      ..getUserDataFromUid(state.user.uid),
                    child: const UserProfileScreen(),
                  ),
                  type: getAppropriateAnimation(context),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
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
          child = const SizedBox();
        }
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          vsync: this,
          child: child,
        );
      },
    );
  }
}

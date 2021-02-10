import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardOwner extends StatefulWidget {
  const CardOwner({
    Key key,
  }) : super(key: key);

  @override
  _CardOwnerState createState() => _CardOwnerState();
}

class _CardOwnerState extends State<CardOwner>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          Widget child;
          if (state is UserMangementHasUserData) {
            child = InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => UserManagementCubit()
                        ..getUserDataFromUid(state.user.uid),
                      child: const UserProfileScreen(),
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: state.user.profilePictureLink,
                      imageBuilder: (context, imageProvider) {
                        return SizedBox(
                          width: 50,
                          child: Ink.image(image: imageProvider),
                        );
                      },
                    ),
                    SizedBox(width: .05.sw),
                    Text(
                      state.user.username,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            );
          } else {
            child = const SizedBox(height: 50, width: 50);
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: child,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

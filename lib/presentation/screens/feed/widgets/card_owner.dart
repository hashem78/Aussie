import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class CardOwner extends StatelessWidget {
  const CardOwner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
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
}

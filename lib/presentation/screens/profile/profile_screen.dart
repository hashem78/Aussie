import 'package:aussie/presentation/screens/profile/widgets/banner.dart';
import 'package:aussie/presentation/screens/profile/widgets/card_stack.dart';
import 'package:aussie/presentation/screens/profile/widgets/events.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  final UserManagementCubit cubit = UserManagementCubit();
  final String uid;
  UserProfileScreen({
    Key key,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (uid == null)
      cubit.getUserData();
    else {
      cubit.getUserDataFromUid(uid);
    }

    return Scaffold(
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        cubit: cubit,
        builder: (context, state) {
          if (state is UserMangementHasUserData) {
            return Provider.value(
              value: state.user,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: .4.sh,
                    //collapsedHeight: .4.sh,
                    pinned: true,
                    flexibleSpace: Stack(
                      overflow: Overflow.visible,
                      children: [
                        BannerImage(
                          colorFilter: ColorFilter.mode(
                            Colors.white.withAlpha(70),
                            BlendMode.lighten,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: -.1.sh,
                          child: ProfileCardStack(),
                        ),
                      ],
                    ),
                  ),
                  ProfileEvents(),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

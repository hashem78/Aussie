import 'package:aussie/presentation/screens/profile/widgets/banner.dart';
import 'package:aussie/presentation/screens/profile/widgets/card_stack.dart';
import 'package:aussie/presentation/screens/profile/widgets/events.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
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
              child: getIndicator(context),
            );
          }
        },
      ),
    );
  }
}

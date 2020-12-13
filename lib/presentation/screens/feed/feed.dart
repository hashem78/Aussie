import 'package:aussie/presentation/screens/feed/tabs/events/tab.dart';
import 'package:aussie/presentation/screens/feed/tabs/home/tab.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return BlocProvider(
      create: (context) => UserManagementCubit()..getUserData(),
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is UserMangementHasUserData) {
            return Provider.value(
              value: state.user,
              child: SafeArea(
                child: AussieScaffold(
                  drawer: AussieAppDrawer(),
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverSafeArea(
                        sliver: SliverAppBar(
                          primary: true,
                          pinned: true,
                          centerTitle: true,
                          title: Text(
                            "Feed",
                            style: TextStyle(
                                fontSize: 60.sp, fontWeight: FontWeight.w400),
                          ),
                          elevation: 0,
                          bottom: TabBar(
                            controller: controller,
                            tabs: [
                              Icon(Icons.home),
                              Icon(Icons.event),
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: TabBarView(
                      controller: controller,
                      children: [
                        HomeTab(),
                        EventsTab(),
                      ],
                    ),
                  ),
                ),
              ),
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

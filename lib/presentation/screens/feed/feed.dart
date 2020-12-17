import 'package:aussie/presentation/screens/feed/events/event_creation.dart';
import 'package:aussie/presentation/screens/feed/tabs/home/tab.dart';
import 'package:aussie/presentation/screens/feed/tabs/public/tab.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';

import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';

import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animations/loading_animations.dart';
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is UserMangementHasUserData) {
            return Provider.value(
              value: state.user,
              child: SafeArea(
                child: AussieScaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (_) => EventCreationBlocForm()),
                              BlocProvider(
                                  create: (_) => EventManagementCubit()),
                              BlocProvider(
                                  create: (_) => MultiImagePickingCubit()),
                              BlocProvider(
                                  create: (_) => SingleImagePickingCubit()),
                              BlocProvider(
                                  create: (_) => LocationPickingCubit()),
                            ],
                            child: EventCreationScreen(),
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.add, size: 100.sp),
                  ),
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
                              Icon(Icons.public),
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: TabBarView(
                      controller: controller,
                      children: [
                        BlocProvider(
                          create: (context) => EventManagementCubit(),
                          child: HomeEventsTab(),
                        ),
                        BlocProvider(
                          create: (context) => EventManagementCubit(),
                          child: PublicEventsTab(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Center(
            child: LoadingBouncingGrid.square(),
          );
        },
      ),
    );
  }
}

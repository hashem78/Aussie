import 'package:aussie/presentation/screens/feed/events/event_creation.dart';
import 'package:aussie/presentation/screens/feed/tabs/home_tab.dart';
import 'package:aussie/presentation/screens/feed/tabs/public_tab.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          if (state is UserMangementHasUserData) {
            return DefaultTabController(
              length: 2,
              child: Provider.value(
                value: state.user,
                child: AussieScaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: MultiBlocProvider(
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
                          type: getAppropriateAnimation(context),
                        ),
                      );
                    },
                    child: Center(child: Icon(Icons.add, size: 20)),
                  ),
                  drawer: AussieAppDrawer(),
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        primary: true,
                        pinned: true,
                        centerTitle: true,
                        title: AutoSizeText(
                          getTranslation(context, "feedScreenTitle"),
                          style: TextStyle(
                              fontSize: 60.sp, fontWeight: FontWeight.w400),
                        ),
                        elevation: 0,
                        bottom: TabBar(
                          tabs: [
                            Icon(Icons.home),
                            Icon(Icons.public),
                          ],
                        ),
                      ),
                    ],
                    body: TabBarView(
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
            child: getIndicator(context),
          );
        },
      ),
    );
  }
}

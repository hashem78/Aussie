import 'package:aussie/presentation/screens/feed/events/event_creation.dart';
import 'package:aussie/presentation/screens/feed/tabs/home_tab.dart';
import 'package:aussie/presentation/screens/feed/tabs/public_tab.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/themes/cubit/theme_cubit.dart';

import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserManagementCubit, UserManagementState>(
          builder: (context, state) {
            if (state is UserMangementHasUserData) {
              return DefaultTabController(
                length: 2,
                child: Provider.value(
                  value: state.user,
                  child: AussieScaffold(
                    floatingActionButton: OpenContainer(
                      transitionDuration: const Duration(seconds: 1),
                      closedShape: const RoundedRectangleBorder(),
                      closedColor:
                          context.watch<BrightnessCubit>().currentBrightness ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.blue,
                      openElevation: 0,
                      openShape: const RoundedRectangleBorder(),
                      closedBuilder: (context, action) {
                        return SizedBox(
                          width: 130,
                          child: FloatingActionButton(
                            onPressed: action,
                            elevation: 0,
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: context
                                        .watch<BrightnessCubit>()
                                        .currentBrightness ==
                                    Brightness.dark
                                ? Colors.white
                                : Colors.blue,
                            child: Center(
                                child: Row(
                              children: const [
                                Expanded(child: Icon(Icons.add, size: 20)),
                                Expanded(flex: 3, child: Text('New event')),
                              ],
                            )),
                          ),
                        );
                      },
                      openBuilder: (context, action) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                                create: (_) => EventCreationBlocForm()),
                            BlocProvider(create: (_) => EventManagementCubit()),
                            BlocProvider(create: (_) => LocationPickingCubit()),
                          ],
                          child: EventCreationScreen(
                            closeAction: action,
                          ),
                        );
                      },
                    ),
                    drawer: const AussieAppDrawer(),
                    body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          pinned: true,
                          centerTitle: true,
                          title: AutoSizeText(
                            getTranslation(context, "feedScreenTitle"),
                            style: TextStyle(
                              fontSize: 100.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          elevation: 0,
                          bottom: const TabBar(
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

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

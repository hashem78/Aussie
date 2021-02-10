import 'package:aussie/presentation/presentation.dart';
import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/brightness/cubit/brightness_cubit.dart';

import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
                  child: const AussieScaffold(
                    floatingActionButton: _FeedAnimatedFAB(),
                    drawer: AussieAppDrawer(),
                    body: _FeedScrollView(),
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

class _FeedScrollView extends StatelessWidget {
  const _FeedScrollView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
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
    );
  }
}

class _FeedAnimatedFAB extends StatelessWidget {
  const _FeedAnimatedFAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieBrightness b =
        context.watch<BrightnessCubit>().currentBrightness;
    Color color;
    if (b is AussieBrightnessSystem) {
      color =
          SchedulerBinding.instance.window.platformBrightness == Brightness.dark
              ? Colors.white
              : Colors.blue;
    } else if (b is AussieBrightnessLight) {
      color = Colors.blue;
    } else if (b is AussieBrightnessDark) {
      color = Colors.white;
    }

    return BlocBuilder<BrightnessCubit, AussieBrightness>(
      builder: (context, state) {
        return OpenContainer(
          closedShape: const RoundedRectangleBorder(),
          closedColor: color,
          openElevation: 0,
          openShape: const RoundedRectangleBorder(),
          closedBuilder: (context, action) {
            return _FeedFAB(color: color, action: action);
          },
          openBuilder: (context, action) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => EventCreationBlocForm()),
                BlocProvider(create: (_) => EventManagementCubit()),
                BlocProvider(create: (_) => LocationPickingCubit()),
              ],
              child: EventCreationScreen(
                closeAction: action,
              ),
            );
          },
        );
      },
    );
  }
}

class _FeedFAB extends StatelessWidget {
  final void Function() action;
  const _FeedFAB({
    Key key,
    @required this.color,
    @required this.action,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: FloatingActionButton(
        onPressed: action,
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        backgroundColor: color,
        child: Center(
            child: Row(
          children: [
            const Expanded(
              child: Icon(Icons.add, size: 20),
            ),
            Expanded(
              flex: 3,
              child: Text(
                getTranslation(
                  context,
                  "eventCreationFabTitle",
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

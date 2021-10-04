import 'package:aussie/aussie_imports.dart';
import 'package:flutter/scheduler.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    Key? key,
    required this.allowEventCreation,
  }) : super(key: key);
  final bool allowEventCreation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          allowEventCreation ? const _FeedAnimatedFAB() : null,
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
                    flexibleSpace: BannerImage(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withAlpha(70),
                        BlendMode.lighten,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: ProfileCard()),
                  BlocProvider(
                    create: (context) => EventManagementCubit(),
                    child: const UserEvents(),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _FeedAnimatedFAB extends StatelessWidget {
  const _FeedAnimatedFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeMode b = context.watch<ThemeModeCubit>().state;
    Color? color;
    if (b == ThemeMode.system) {
      color = SchedulerBinding.instance!.window.platformBrightness ==
              Brightness.dark
          ? Colors.white
          : Colors.blue;
    } else if (b == ThemeMode.light) {
      color = Colors.blue;
    } else if (b == ThemeMode.dark) {
      color = Colors.white;
    }

    return BlocBuilder<ThemeModeCubit, ThemeMode>(
      builder: (context, state) {
        return OpenContainer(
          closedShape: const RoundedRectangleBorder(),
          closedColor: color!,
          openElevation: 0,
          openShape: const RoundedRectangleBorder(),
          closedBuilder: (context, action) {
            return _FeedFAB(color: color, action: action);
          },
          openBuilder: (context, action) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (BuildContext context) => EventCreationBlocForm()),
                BlocProvider(
                    create: (BuildContext context) => EventManagementCubit()),
                BlocProvider(
                    create: (BuildContext context) => LocationPickingCubit()),
                BlocProvider(
                    create: (BuildContext context) =>
                        SingleImagePickingCubit()),
                BlocProvider(
                    create: (BuildContext context) => MultiImagePickingCubit()),
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
    Key? key,
    required this.color,
    required this.action,
  }) : super(key: key);

  final Color? color;

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
                  )!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

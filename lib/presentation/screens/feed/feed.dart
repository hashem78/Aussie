import 'package:aussie/aussie_imports.dart';
import 'package:flutter/scheduler.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          const TabBar tabBar = TabBar(
            tabs: [
              Icon(Icons.home),
              Icon(Icons.public),
            ],
          );
          return AussieScaffold(
            drawer: const AussieAppDrawer(),
            floatingActionButton: const _FeedAnimatedFAB(),
            appBar: PreferredSize(
              preferredSize: Size(
                double.infinity,
                tabBar.preferredSize.height + kToolbarHeight,
              ),
              child: AppBar(
                centerTitle: true,
                title: AutoSizeText(
                  getTranslation(context, "feedScreenTitle")!,
                  style: TextStyle(
                    fontSize: 100.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                elevation: 0,
                bottom: tabBar,
              ),
            ),
            body: state is UserMangementHasUserData
                ? Provider.value(
                    value: state.user,
                    child: TabBarView(
                      children: [
                        BlocProvider(
                          create: (context) => EventManagementCubit(),
                          child: const HomeEventsTab(),
                        ),
                        BlocProvider(
                          create: (context) => EventManagementCubit(),
                          child: const PublicEventsTab(),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
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
    final AussieBrightness b =
        context.watch<BrightnessCubit>().currentBrightness;
    Color? color;
    if (b is AussieBrightnessSystem) {
      color = SchedulerBinding.instance!.window.platformBrightness ==
              Brightness.dark
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

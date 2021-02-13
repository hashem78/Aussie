import 'package:aussie/aussie_imports.dart';

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

import 'package:aussie/aussie_imports.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen();
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final PagingController<int, WeatherModel> _pagingController =
      PagingController<int, WeatherModel>(firstPageKey: 0);

  final List<LatLng> _coords = const [
    LatLng(-34.93, 138.6),
    LatLng(-33.861481, 151.205475),
    LatLng(-37.813938, 144.963425),
    LatLng(-27.47101, 153.024292),
    LatLng(-31.95224, 115.861397),
    LatLng(-28.00029, 153.430878),
    LatLng(-35.27603, 149.13435),
    LatLng(-32.927792, 151.784485),
  ];
  int modelToBeLoadedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pagingController.addPageRequestListener(
      (index) {
        context.read<WeatherCubit>().fetch(_coords[index]);
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ThumbnailCubit(AussieScreenData.weatherThumbnailRoute),
      child: AussieThemeBuilder(
        builder: (BuildContext context, color) {
          return Scaffold(
            backgroundColor: color.backgroundColor,
            body: CustomScrollView(
              slivers: [
                AussieThumbnailedAppBar(
                  title: getTranslation(context, "weatherTitle"),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      Widget child;
                      if (state is WeatherError) {
                        child = Text(getTranslation(context, "weatherError")!);
                      } else {
                        final String formattedTime =
                            DateFormat("dd-MM-YY hh:mm").format(DateTime.now());
                        child = Text("Data as of $formattedTime local time");
                      }
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: child,
                      );
                    },
                  ),
                ),
                BlocListener<WeatherCubit, WeatherState>(
                  listener: (context, state) {
                    if (state is WeatherLoaded) {
                      if (_pagingController.nextPageKey! + 1 < _coords.length) {
                        _pagingController.appendPage(
                          [state.model],
                          _pagingController.nextPageKey! + 1,
                        );
                      } else {
                        _pagingController.appendLastPage([state.model]);
                      }
                    }
                  },
                  child: PagedSliverList<int, WeatherModel>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, item, index) {
                        return WeatherTile(
                          model: item,
                          showTitle: true,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        dark: AussieScreenColorData.weatherDark,
        light: AussieScreenColorData.weatherLight,
      ),
    );
  }
}

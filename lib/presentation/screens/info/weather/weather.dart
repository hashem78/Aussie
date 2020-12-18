import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/presentation/widgets/aussie/thumbnailed_appbar.dart';
import 'package:aussie/presentation/screens/info/weather/weather_tile.dart';
import 'package:aussie/state/thumbnail/cubit/thumbnail_cubit.dart';
import 'package:aussie/state/weather/cubit/weather_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "teritory_images",
    navPath: "/main/info/weather",
    svgName: "weather.svg",
    tTitle: "weatherTitle",
    themeAttribute: "weatherScreenColor",
    dark: AussieColorData(
      swatchColor: Colors.lightBlue.shade700,
      backgroundColor: Colors.lightBlue.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.lightBlue.shade400,
      backgroundColor: Colors.lightBlue.shade300,
    ),
  );

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  PagingController<int, WeatherModel> _pagingController =
      PagingController<int, WeatherModel>(firstPageKey: 0);

  List<LatLng> _coords = [
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
  void initState() {
    super.initState();
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
    var _currentTheme = getCurrentThemeModel(context).weatherScreenColor;
    return Provider.value(
      value: _currentTheme,
      child: Scaffold(
        backgroundColor: _currentTheme.backgroundColor,
        body: BlocProvider(
          create: (context) =>
              ThumbnailCubit(WeatherScreen.data.thumbnailRoute)..fetch(),
          child: Builder(
            builder: (context) => CustomScrollView(
              slivers: [
                AussieThumbnailedAppBar(
                  title: getTranslation(context, "weatherTitle"),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      Widget child;
                      if (state is WeatherLoading) {
                        child = Container(
                          child:
                              Text(getTranslation(context, "weatherFetching")),
                        );
                      } else if (state is WeatherError) {
                        child = Container(
                          child: Text(getTranslation(context, "weatherError")),
                        );
                      } else {
                        String formattedTime =
                            DateFormat("dd-MM-YY hh:mm").format(DateTime.now());
                        child = Container(
                          child: Text("Data as of $formattedTime local time"),
                        );
                      }
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: child,
                      );
                    },
                  ),
                ),
                BlocListener<WeatherCubit, WeatherState>(
                  listener: (context, state) {
                    if (state is WeatherLoaded) {
                      if (_pagingController.nextPageKey + 1 < _coords.length) {
                        _pagingController.appendPage(
                          [state.model],
                          _pagingController.nextPageKey + 1,
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
          ),
        ),
      ),
    );
  }
}

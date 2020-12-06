import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/thumbnailed_sliver_appbar.dart';
import 'package:aussie/presentation/widgets/aussie/weather_tile.dart';
import 'package:aussie/state/thumbnail/cubit/thumbnail_cubit.dart';
import 'package:aussie/state/weather/cubit/weather_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  final WeatherCubit cubit = WeatherCubit();
  final ThumbnailCubit thumbnailCubit =
      ThumbnailCubit(WeatherScreen.data.thumbnailRoute);
  GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  List<WeatherModel> models = [];
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

    cubit.fetch(_coords[0]);
  }

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).weatherScreenColor;
    return Provider.value(
      value: _currentTheme,
      child: AussieScaffold(
        drawer: getAppDrawer(context),
        backgroundColor: _currentTheme.backgroundColor,
        body: CustomScrollView(
          slivers: [
            AussieThumbnailedSliverAppBar(
              cubit: thumbnailCubit,
              title: getTranslation(context, "weatherTitle"),
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
              cubit: cubit,
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: Container(),
                );
              },
            ),
            BlocListener<WeatherCubit, WeatherState>(
              cubit: cubit,
              listener: (context, state) {
                if (state is WeatherLoaded) {
                  _listKey.currentState.insertItem(models.length);
                  models.add(state.model);
                  if (models.length < _coords.length)
                    cubit.fetch(_coords[models.length]);
                }
              },
              child: SliverAnimatedList(
                initialItemCount: 0,
                key: _listKey,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  Animation<double> animation,
                ) {
                  return AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    vsync: this,
                    child: Container(
                      height: animation.value * .4.sh,
                      padding: index != 0
                          ? const EdgeInsets.fromLTRB(10, 0, 10, 10)
                          : const EdgeInsets.all(10),
                      child: WeatherTile(
                        model: models[index],
                        showTitle: true,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/presentation/widgets/aussie/thumbnailed_sliver_appbar.dart';
import 'package:aussie/presentation/widgets/aussie/weather_tile.dart';
import 'package:aussie/state/thumbnail/thumbnail_cubit.dart';
import 'package:aussie/state/weather/cubit/weather_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherScreen extends StatefulWidget {
  static String navPath = "/main/info/weather";
  static String svgName = "weather.svg";
  static String title = "Weather";

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  final WeatherCubit cubit = WeatherCubit();
  final ThumbnailCubit thumbnailCubit = ThumbnailCubit("teritory_images");
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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        cubit.fetch(_coords[0]);
      },
    );

    thumbnailCubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          AussieThumbnailedSliverAppBar(
            cubit: thumbnailCubit,
            title: "Weather",
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
                  duration: Duration(milliseconds: 500),
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
    );
  }
}

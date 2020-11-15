import 'package:aussie/presentation/widgets/aussie/thumbnailed_sliver_appbar.dart';
import 'package:aussie/presentation/widgets/aussie/weather_tile.dart';
import 'package:aussie/state/thumbnail/thumbnail_cubit.dart';
import 'package:aussie/state/weather/cubit/weather_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherScreen extends StatefulWidget {
  static String navPath = "/main/info/weather";
  static String svgName = "weather.svg";
  static String title = "Weather";

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherCubit cubit = WeatherCubit();
  final ThumbnailCubit thumbnailCubit = ThumbnailCubit("teritory_images");
  @override
  void initState() {
    super.initState();
    thumbnailCubit.fetch();
    cubit.fetch([
      LatLng(-34.93, 138.6),
      LatLng(-33.861481, 151.205475),
      LatLng(-37.813938, 144.963425),
      LatLng(-27.47101, 153.024292),
      LatLng(-31.95224, 115.861397),
      LatLng(-28.00029, 153.430878),
      LatLng(-35.27603, 149.13435),
      LatLng(-32.927792, 151.784485),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AussieThumbnailedSliverAppBar(
            cubit: thumbnailCubit,
            title: "Weather",
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            cubit: cubit,
            builder: (context, state) {
              if (state is WeatherLoading) {
                return SliverPadding(
                  padding: EdgeInsets.only(top: 5),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else if (state is WeatherLoaded) {
                return SliverPadding(
                  padding: EdgeInsets.only(top: 2.5),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return WeatherTile(
                          model: state.models[index],
                          showTitle: true,
                        );
                      },
                      childCount: state.models.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(child: Container());
            },
          )
        ],
      ),
    );
  }
}

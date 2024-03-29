import 'package:aussie/models/themes/color_data_model.dart';
import 'package:aussie/state/thumbnail_cubit/thumbnail_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AussieThumbnailedAppBar extends StatelessWidget {
  final String? title;
  final double height;
  AussieThumbnailedAppBar({
    Key? key,
    required this.title,
    double? height,
  })  : height = height ?? .35.sh,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ThumbnailCubit>().fetch();
    return SliverAppBar(
      backgroundColor: AussieThemeProvider.of(context).color.backgroundColor,
      pinned: true,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title!),
        centerTitle: true,
        background: BlocBuilder<ThumbnailCubit, ThumbnailState>(
          builder: (BuildContext context, ThumbnailState state) {
            if (state is ThumbnailLoading) {
              return CarouselSlider(
                items: const <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
              );
            } else if (state is ThumbnailLoaded) {
              return CarouselSlider.builder(
                itemCount: state.imageUrls.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return buildImage(
                    state.imageUrls[index],
                    showPlaceHolder: false,
                    fadeIn: Duration.zero,
                    fit: BoxFit.cover,
                  )!;
                },
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 10),
                ),
              );
            }
            return Icon(Icons.wifi_off, size: 300.sp);
          },
        ),
      ),
    );
  }
}

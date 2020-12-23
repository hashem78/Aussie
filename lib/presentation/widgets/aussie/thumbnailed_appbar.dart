import 'package:aussie/state/thumbnail/cubit/thumbnail_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AussieThumbnailedAppBar extends StatelessWidget {
  final String title;
  final double height;
  AussieThumbnailedAppBar({
    @required this.title,
    double height,
  }) : height = height ?? .5.sh;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: getColorData(context).swatchColor,
      pinned: true,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        centerTitle: true,
        background: BlocBuilder<ThumbnailCubit, ThumbnailState>(
          builder: (context, state) {
            if (state is ThumbnailLoading) {
              return CarouselSlider(
                items: [Center(child: getIndicator(context))],
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                ),
              );
            } else if (state is ThumbnailLoaded) {
              return CarouselSlider.builder(
                itemCount: state.imageUrls.length,
                itemBuilder: (context, index) => buildImage(
                  state.imageUrls[index],
                  showPlaceHolder: false,
                  fadeIn: Duration.zero,
                  fit: BoxFit.cover,
                ),
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

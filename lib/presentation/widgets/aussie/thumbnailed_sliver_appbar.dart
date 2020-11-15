import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/state/thumbnail/thumbnail_cubit.dart';

class AussieThumbnailedSliverAppBar extends StatelessWidget {
  final ThumbnailCubit cubit;
  final String title;
  const AussieThumbnailedSliverAppBar({
    @required this.cubit,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.cyan.shade700,
      stretch: true,
      expandedHeight: .5.sh,
      title: Text(title),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: BlocBuilder<ThumbnailCubit, ThumbnailState>(
          cubit: cubit,
          builder: (context, state) {
            if (state is ThumbnailLoading) {
              return CarouselSlider(
                items: [
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  )
                ],
                options: CarouselOptions(
                  height: .5.sh,
                  viewportFraction: 1,
                  pageSnapping: false,
                  autoPlay: true,
                ),
              );
            } else if (state is ThumbnailLoaded) {
              return CarouselSlider.builder(
                itemCount: state.imageUrls.length,
                itemBuilder: (context, index) => buildImage(
                  state.imageUrls[index],
                  showPlaceHolder: false,
                  fadeInDuration: Duration.zero,
                  fit: BoxFit.fill,
                ),
                options: CarouselOptions(
                  height: .5.sh,
                  viewportFraction: 1,
                  pageSnapping: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 10),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

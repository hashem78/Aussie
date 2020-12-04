import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/state/thumbnail/thumbnail_cubit.dart';

class AussieThumbnailedSliverAppBar extends StatefulWidget {
  final ThumbnailCubit cubit;
  final String title;
  final Color backgroundColor;
  const AussieThumbnailedSliverAppBar({
    @required this.cubit,
    @required this.title,
    @required this.backgroundColor,
  });

  @override
  _AussieThumbnailedSliverAppBarState createState() =>
      _AussieThumbnailedSliverAppBarState();
}

class _AussieThumbnailedSliverAppBarState
    extends State<AussieThumbnailedSliverAppBar> {
  @override
  void initState() {
    widget.cubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: widget.backgroundColor,
      pinned: true,
      primary: true,
      expandedHeight: .5.sh,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.title),
        centerTitle: true,
        background: BlocBuilder<ThumbnailCubit, ThumbnailState>(
          cubit: widget.cubit,
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
                  enableInfiniteScroll: false,
                ),
              );
            } else if (state is ThumbnailLoaded) {
              return CarouselSlider.builder(
                itemCount: state.imageUrls.length,
                itemBuilder: (context, index) => buildImage(
                  state.imageUrls[index],
                  showPlaceHolder: false,
                  fadeInDuration: Duration.zero,
                  fit: BoxFit.cover,
                ),
                options: CarouselOptions(
                  height: .5.sh,
                  viewportFraction: 1,
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

import 'package:aussie/interfaces/cubit/paginated_screen.dart';
import 'package:aussie/interfaces/paginated_data_model.dart';
import 'package:aussie/presentation/widgets/paginated/search_bar.dart';
import 'package:aussie/state/thumbnail/thumbnail_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../state/paginated/common/paginated_screen_state.dart';

class SearchablePaginatedScreen extends StatefulWidget {
  final PaginatedScreenCubit cubit;
  final String thumbnailCubitRoute;
  final String title;

  final Widget Function(BuildContext, PaginatedDataModel, int) itemBuilder;

  SearchablePaginatedScreen({
    @required this.cubit,
    @required this.thumbnailCubitRoute,
    @required this.itemBuilder,
    @required this.title,
  });
  @override
  _SearchablePaginatedScreenState createState() =>
      _SearchablePaginatedScreenState(thumbnailCubitRoute);
}

class _SearchablePaginatedScreenState extends State<SearchablePaginatedScreen> {
  static int _pageSize = 10;
  ThumbnailCubit thumbnailCubit;
  final String route;
  PagingController<int, PaginatedDataModel> _controller =
      PagingController<int, PaginatedDataModel>(firstPageKey: 0);

  _SearchablePaginatedScreenState(this.route);

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  String searchQuery = "";
  @override
  void initState() {
    thumbnailCubit = ThumbnailCubit(route);
    thumbnailCubit.fetch();
    _controller.addPageRequestListener((pageKey) {
      if (searchQuery.isNotEmpty) {
        widget.cubit.filter(searchQuery);
      } else {
        widget.cubit.loadMoreAsync(
          page: pageKey,
          amount: _pageSize,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.cyan.shade700,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.cyan.shade700,
              stretch: true,
              expandedHeight: .5.sh,
              title: Text(widget.title),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: BlocBuilder<ThumbnailCubit, ThumbnailState>(
                  cubit: thumbnailCubit,
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
            ),
            PaginatedSearchBar(
              onChanged: (val) {
                searchQuery = val;
                _controller.refresh();
              },
            ),
            BlocListener<PaginatedScreenCubit, PaginatedScreenState>(
              cubit: widget.cubit,
              listener: (context, state) {
                if (state is PaginatedScreenInitialLoaded) {
                  _controller.appendPage(state.models, _pageSize);
                } else if (state is PaginatedScreenDataChanged) {
                  final nextKey = _controller.nextPageKey + state.models.length;
                  _controller.appendPage(state.models, nextKey);
                } else if (state is PaginatedScreenEnd) {
                  _controller.appendLastPage(state.models);
                } else if (state is PaginatedScreenFiltered) {
                  _controller.appendLastPage(state.models);
                }
              },
              child: buildSliverList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSliverList() {
    return PagedSliverList<int, PaginatedDataModel>(
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<PaginatedDataModel>(
        itemBuilder: widget.itemBuilder,
        noItemsFoundIndicatorBuilder: (_) => Container(
          height: 100,
          child: Center(
            child: Text("No items found"),
          ),
        ),
        noMoreItemsIndicatorBuilder: (_) => Container(
          height: 50,
          child: Center(
            child: Text(
              "No more items to show",
            ),
          ),
        ),
      ),
    );
  }
}

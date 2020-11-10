import 'package:Aussie/constants.dart';
import 'package:Aussie/interfaces/cubit/paginated_screen.dart';
import 'package:Aussie/interfaces/paginated_data_model.dart';
import 'package:Aussie/presentation/widgets/paginated/search_bar.dart';

import 'package:Aussie/util/functions.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../state/paginated/common/paginated_screen_state.dart';

class SearchablePaginatedScreen extends StatefulWidget {
  final PaginatedScreenCubit cubit;
  final Widget Function(BuildContext, PaginatedDataModel, int) itemBuilder;

  const SearchablePaginatedScreen(
      {@required this.cubit, @required this.itemBuilder});
  @override
  _SearchablePaginatedScreenState createState() =>
      _SearchablePaginatedScreenState();
}

class _SearchablePaginatedScreenState extends State<SearchablePaginatedScreen> {
  static int _pageSize = 10;

  PagingController<int, PaginatedDataModel> _controller =
      PagingController<int, PaginatedDataModel>(firstPageKey: 0);

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  String searchQuery = "";
  @override
  void initState() {
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
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: CarouselSlider(
                  items: [buildImage(kurl)],
                  options: CarouselOptions(
                    height: .5.sh,
                    viewportFraction: 1,
                    pageSnapping: false,
                    autoPlay: true,
                  ),
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

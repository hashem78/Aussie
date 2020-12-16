import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/presentation/widgets/aussie/thumbnailed_appbar.dart';
import 'package:aussie/presentation/widgets/paginated/search_bar.dart';
import 'package:aussie/state/paginated/cubit/paginated_cubit.dart';
import 'package:aussie/state/thumbnail/cubit/thumbnail_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchablePaginatedScreen extends StatefulWidget {
  final String route;
  final String thumbnailRoute;
  final String title;
  final String filterFor;

  final Widget Function(BuildContext, IPaginatedData, int) itemBuilder;

  SearchablePaginatedScreen({
    @required this.route,
    @required this.thumbnailRoute,
    @required this.itemBuilder,
    @required this.title,
    @required this.filterFor,
  });
  @override
  _SearchablePaginatedScreenState createState() =>
      _SearchablePaginatedScreenState();
}

class _SearchablePaginatedScreenState extends State<SearchablePaginatedScreen> {
  static int _pageSize = 10;

  PagingController<int, IPaginatedData> _controller =
      PagingController<int, IPaginatedData>(firstPageKey: 0);
  PaginatedCubit cubit;

  @override
  void dispose() {
    cubit.close();
    cubit = PaginatedCubit(widget.route);
    _controller.dispose();
    _controller = null;

    super.dispose();
  }

  String searchQuery = "";
  @override
  void initState() {
    _controller.addPageRequestListener((pageKey) {
      if (searchQuery.isNotEmpty && searchQuery != null) {
        cubit.filter(widget.filterFor, searchQuery);
      } else {
        cubit.loadMoreAsync(
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
        backgroundColor: getColorData(context).backgroundColor,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ThumbnailCubit(widget.route)..fetch(),
            ),
            BlocProvider.value(value: cubit),
          ],
          child: CustomScrollView(
            slivers: [
              AussieThumbnailedAppBar(
                title: widget.title,
              ),
              PaginatedSearchBar(
                onSubmitted: (val) {
                  searchQuery = val;
                  _controller.refresh();
                },
              ),
              BlocListener<PaginatedCubit, PaginatedState>(
                listener: (context, state) {
                  if (state is PaginatedInitialLoaded) {
                    _controller.appendPage(state.models, _pageSize);
                  } else if (state is PaginatedDataChanged) {
                    final nextKey =
                        _controller.nextPageKey + state.models.length;
                    _controller.appendPage(state.models, nextKey);
                  } else if (state is PaginatedEnd) {
                    _controller.appendLastPage(state.models);
                  } else if (state is PaginatedFiltered) {
                    _controller.appendLastPage(state.models);
                  }
                },
                child: buildSliverList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSliverList() {
    return PagedSliverList<int, IPaginatedData>(
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<IPaginatedData>(
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

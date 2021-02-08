import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/widgets/aussie/thumbnailed_appbar.dart';
import 'package:aussie/presentation/widgets/paginated/search_bar.dart';
import 'package:aussie/state/paginated/cubit/paginated_cubit.dart';
import 'package:aussie/state/thumbnail/cubit/thumbnail_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchablePaginatedScreen<T extends IPaginatedData>
    extends StatefulWidget {
  final String thumbnailCubitRoute;
  final String title;
  final String filterFor;

  final bool _isList;

  final Widget Function(BuildContext, IPaginatedData, int) itemBuilder;

  const SearchablePaginatedScreen({
    @required this.thumbnailCubitRoute,
    @required this.itemBuilder,
    @required this.title,
    @required this.filterFor,
  }) : _isList = false;
  const SearchablePaginatedScreen.list({
    @required this.thumbnailCubitRoute,
    @required this.itemBuilder,
    @required this.title,
    @required this.filterFor,
  }) : _isList = true;
  @override
  _SearchablePaginatedScreenState<T> createState() =>
      _SearchablePaginatedScreenState<T>();
}

class _SearchablePaginatedScreenState<T extends IPaginatedData>
    extends State<SearchablePaginatedScreen<T>> {
  static const int _pageSize = 10;
  ThumbnailCubit thumbnailCubit;
  PagingController<int, IPaginatedData> _controller =
      PagingController<int, IPaginatedData>(firstPageKey: 0);

  _SearchablePaginatedScreenState();

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }

  String searchQuery = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.addPageRequestListener(
      (pageKey) {
        if (searchQuery.isNotEmpty && searchQuery != null) {
          context
              .read<PaginatedCubit<T>>()
              .filter(widget.filterFor, searchQuery);
        } else {
          context.read<PaginatedCubit<T>>().loadMoreAsync(
                page: pageKey,
                amount: _pageSize,
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AussieThemeProvider.of(context).color.backgroundColor,
        body: CustomScrollView(
          slivers: [
            BlocProvider(
              create: (context) =>
                  ThumbnailCubit(widget.thumbnailCubitRoute)..fetch(),
              child: AussieThumbnailedAppBar(
                title: widget.title,
              ),
            ),
            PaginatedSearchBar(
              onSubmitted: (val) {
                searchQuery = val;
                _controller.refresh();
              },
            ),
            BlocListener<PaginatedCubit<T>, PaginatedState>(
              listener: (context, state) {
                if (state is PaginatedInitialLoaded) {
                  _controller.appendPage(state.models, _pageSize);
                } else if (state is PaginatedDataChanged) {
                  final nextKey = _controller.nextPageKey + state.models.length;
                  _controller.appendPage(state.models, nextKey);
                } else if (state is PaginatedEnd) {
                  _controller.appendLastPage(state.models);
                } else if (state is PaginatedFiltered) {
                  _controller.appendLastPage(state.models);
                }
              },
              child: widget._isList ? buildSliverList() : buildSliverGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSliverGrid() {
    return PagedSliverGrid<int, IPaginatedData>(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<IPaginatedData>(
        itemBuilder: widget.itemBuilder,
        noItemsFoundIndicatorBuilder: (_) => SizedBox(
          height: 100,
          child: Center(
            child: Text(
                getTranslation(context, "searchablePaginatedNoItemsFound")),
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
        noItemsFoundIndicatorBuilder: (_) => SizedBox(
          height: 100,
          child: Center(
            child: Text(
                getTranslation(context, "searchablePaginatedNoItemsFound")),
          ),
        ),
      ),
    );
  }
}

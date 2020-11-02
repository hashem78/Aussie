import 'package:Aussie/widgets/aussie/teritory_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/models/teritories/teritory.dart';
import 'package:Aussie/state/teritories/teritories_cubit.dart';
import 'package:Aussie/util/functions.dart';

class TeritoriesScreen extends StatefulWidget {
  static String navPath = "/main/info/teritories";
  static String svgName = "australia.svg";
  static String title = "Teritories";

  @override
  _TeritoriesScreenState createState() => _TeritoriesScreenState();
}

class _TeritoriesScreenState extends State<TeritoriesScreen> {
  final TeritoriesCubit cubit = TeritoriesCubit();
  PagingController<int, TeritoryModel> _controller =
      PagingController<int, TeritoryModel>(firstPageKey: 0);

  static int _pageSize = 10;
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
        cubit.filter(searchQuery);
      } else {
        cubit.loadMoreAsync(_pageSize);
      }
    });
    _controller.addStatusListener(
      (status) {
        print(status);
      },
    );
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
              expandedHeight: 300.h,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: CarouselSlider(
                  items: [buildImage(kurl)],
                  options: CarouselOptions(
                    height: 300.h,
                    viewportFraction: 1,
                    pageSnapping: false,
                    autoPlay: true,
                  ),
                ),
              ),
            ),
            _TeritorySearchBar(
              onChanged: (val) {
                searchQuery = val;
                _controller.refresh();
              },
            ),
            BlocListener<TeritoriesCubit, TeritoriesState>(
              cubit: cubit,
              listener: (context, state) {
                if (state is TeritoriesInitialLoaded) {
                  _controller.appendPage(state.models, _pageSize);
                } else if (state is TeritoriesDataChanged) {
                  final nextKey = _controller.nextPageKey + state.models.length;
                  _controller.appendPage(state.models, nextKey);
                } else if (state is TeritoriesEnd) {
                  _controller.appendLastPage(state.models);
                } else if (state is TeritoriesFiltered) {
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
    return PagedSliverList<int, TeritoryModel>(
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<TeritoryModel>(
        itemBuilder: (context, item, index) {
          return TeritoryTile(model: item);
        },
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

class _TeritorySearchBar extends StatelessWidget {
  final void Function(String) onChanged;
  const _TeritorySearchBar({@required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Icon(
              Icons.search,
              size: 45,
              color: Colors.white.withOpacity(.8),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: TextField(
                onChanged: onChanged,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

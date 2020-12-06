import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/main/details.dart';
import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/state/efe/cubit/efe_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AussiePagedListView<T extends MainScreenDetailsModel>
    extends StatefulWidget {
  final String route;
  final MainScreenDetailsModel Function(Map<String, dynamic> map) creator;

  const AussiePagedListView(
    this.route,
    this.creator,
  );
  @override
  _AussiePagedListViewState<T> createState() => _AussiePagedListViewState<T>();
}

class _AussiePagedListViewState<T extends MainScreenDetailsModel>
    extends State<AussiePagedListView<T>> {
  EFECubit<T> cubit;
  PagingController<int, MainScreenDetailsModel> _pagingController =
      PagingController<int, MainScreenDetailsModel>(firstPageKey: 0);
  @override
  void initState() {
    super.initState();
    cubit = EFECubit<T>(
      widget.route,
      widget.creator,
    );
    _pagingController.addPageRequestListener(
      (pageKey) {
        cubit.loadMore(pageKey);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EFECubit<T>, EFEState>(
      cubit: cubit,
      listener: (context, state) {
        if (state is EFEDataChanged) {
          if (state.models.isNotEmpty) {
            _pagingController.appendPage(
              state.models,
              _pagingController.nextPageKey + state.models.length,
            );
          } else {
            _pagingController.appendLastPage([]);
          }
        }
      },
      child: PagedSliverList<int, MainScreenDetailsModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MainScreenDetailsModel>(
          itemBuilder: (context, model, index) {
            return SizedTile.withDetails(
              widthFactor: 1.sw,
              containerMargin: EdgeInsets.all(5),
              heightFactor: .75.sh,
              swatchHeightFactor: .05.sh,
              swatchColor: Provider.of<AussieColorData>(context).swatchColor,
              swatchWidthFactor: 1.sw,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return EFEDetails<MainScreenDetailsModel>(
                        model: model,
                        colorData: Provider.of<AussieColorData>(context),
                      );
                    },
                  ),
                );
              },
              image: buildImage(model.imageLinks.first, fit: BoxFit.cover),
              title: model.title,
            );
          },
          noMoreItemsIndicatorBuilder: (context) => Center(
            child: Text("No more items to show"),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/main/main.dart';
import 'package:aussie/state/efe/cubit/efe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AussieFeaturedListView<T extends MainScreenDetailsModel>
    extends StatefulWidget {
  final String route;
  final MainScreenDetailsModel Function(Map<String, dynamic> map) creator;

  const AussieFeaturedListView(this.route, this.creator);
  @override
  _AussieFeaturedListViewState<T> createState() =>
      _AussieFeaturedListViewState<T>();
}

class _AussieFeaturedListViewState<T extends MainScreenDetailsModel>
    extends State<AussieFeaturedListView<T>> {
  EFECubit<T> cubit;
  @override
  void initState() {
    super.initState();
    cubit = EFECubit<T>(
      widget.route,
      widget.creator,
    );
    cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EFECubit<T>, EFEState>(
      cubit: cubit,
      builder: (context, state) {
        if (state is EFEDataChanged) {
          return SliverToBoxAdapter(
            child: buildTiles(state.models),
          );
        }
        return SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildTiles(List<MainScreenDetailsModel> models) {
    return AussieTileList(
      models: models,
      widthFactor: .75.sw,
      heightFactor: .20.sh,
      swatchWidthFactor: 1.sw,
      swatchHeightFactor: .03.sh,
      titleImageHeight: 1.sh,
      listHeightFactor: .6.sh,
      detailsColorData: Provider.of<AussieColorData>(context),
    );
  }
}

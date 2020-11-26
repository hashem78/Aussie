import 'package:aussie/models/main_screen/explore/people/details.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/screens/main/main.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:aussie/state/efe/cubit/efe_cubit.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeopleScreen extends StatefulWidget {
  static final String themeAttribute = "peopleScreenColor";

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final EFECubit<PeopleDetailsModel> cubit = EFECubit<PeopleDetailsModel>(
    "movies_list",
    (Map<String, dynamic> map) => PeopleDetailsModel.fromMap(map),
  );
  @override
  void initState() {
    super.initState();
    cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context);
    return Scaffold(
      drawer: AussieAppDrawer(),
      backgroundColor: _currentTheme.peopleScreenColor.backgroundColor,
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(_currentTheme.peopleScreenColor.swatchColor),
          BlocBuilder<EFECubit<PeopleDetailsModel>, EFEState>(
            cubit: cubit,
            builder: (context, state) {
              if (state is EFEDataChanged)
                return SliverToBoxAdapter(
                  child: buildTiles(0, state.models),
                );
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTiles(
      double initialScrollOffset, List<MainScreenDetailsModel> models) {
    return MainScreen.buildTiles(
      models,
      widthFactor: .55.sw,
      heightFactor: .20.sh,
      swatchWidthFactor: 1.sw,
      swatchHeightFactor: .05.sh,
      titleImageHeight: .8.sh,
      listHeightFactor: .61.sh,
      swatchColor: Colors.red,
      listScrollOffset: initialScrollOffset,
    );
  }
}

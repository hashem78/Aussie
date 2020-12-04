import 'package:aussie/models/main_screen/entertainment/details.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/screens/main/main.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/state/efe/cubit/efe_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntertainmentScreen extends StatefulWidget {
  static final data = AussieScreenData(
    thumbnailRoute: "teritory_images",
    themeAttribute: "entertainmentScreenColor",
    tTitle: "entertainmentTitle",
    svgName: "entertainment.svg",
    navPath: "/entertainment",
    dark: AussieColorData(
      swatchColor: Colors.lightBlue.shade700,
      backgroundColor: Colors.lightBlue.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.lightBlue.shade400,
      backgroundColor: Colors.lightBlue.shade300,
    ),
  );
  @override
  _EntertainmentScreenState createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  final EFECubit<EntertainmentDetailsModel> cubit =
      EFECubit<EntertainmentDetailsModel>(
    "movies_list",
    (Map<String, dynamic> map) => EntertainmentDetailsModel.fromMap(map),
  );
  @override
  void initState() {
    super.initState();
    cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context);
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: _currentTheme.entertainmentScreenColor.backgroundColor,
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(
            _currentTheme.entertainmentScreenColor.swatchColor,
            getTranslation(context, EntertainmentScreen.data.tTitle),
          ),
          BlocBuilder<EFECubit<EntertainmentDetailsModel>, EFEState>(
            cubit: cubit,
            builder: (context, state) {
              if (state is EFEDataChanged) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      buildTiles(
                        0,
                        [...state.models, ...state.models, ...state.models],
                      ),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            tileColor: Colors.brown,
                            leading: Icon(Icons.ac_unit),
                          ),
                          ListTile(
                            tileColor: Colors.brown,
                            leading: Icon(Icons.ac_unit),
                          ),
                          ListTile(
                            tileColor: Colors.brown,
                            leading: Icon(Icons.ac_unit),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
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

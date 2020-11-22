import 'package:aussie/models/efe/efe.dart';

import 'package:aussie/models/efe/food_and_drinks/details.dart';

import 'package:aussie/presentation/screens/efe/efe.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:aussie/state/efe/cubit/efe_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodAndDrinks extends StatefulWidget {
  @override
  _FoodAndDrinksState createState() => _FoodAndDrinksState();
}

class _FoodAndDrinksState extends State<FoodAndDrinks> {
  final EFECubit<FoodAndDrinksDetailsModel> cubit =
      EFECubit<FoodAndDrinksDetailsModel>(
    "movies_list",
    (Map<String, dynamic> map) => FoodAndDrinksDetailsModel.fromMap(map),
  );
  @override
  void initState() {
    super.initState();
    cubit.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AussieAppDrawer(),
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(title: 'Food & Drinks'),
          BlocBuilder<EFECubit<FoodAndDrinksDetailsModel>, EFEState>(
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

  Widget buildTiles(double initialScrollOffset, List<EFEModel> models) {
    return EFEScreen.buildEFETiles(
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

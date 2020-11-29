import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:aussie/state/dyk/cubit/dyk_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DYKScreen extends StatefulWidget {
  static final data = AussieScreenData(
    title: "Did you know...",
    navPath: "/dyk",
    svgName: "dyk.svg",
    themeAttribute: "dykScreenColor",
    dark: AussieColorData(
      swatchColor: Colors.blue.shade700,
      backgroundColor: Colors.blue.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.blue.shade400,
      backgroundColor: Colors.blue.shade300,
    ),
  );
  @override
  _DYKScreenState createState() => _DYKScreenState();
}

class _DYKScreenState extends State<DYKScreen> {
  bool left;
  bool right;
  DykCubit cubit = DykCubit();

  @override
  void initState() {
    cubit.fetch();
    left = false;
    right = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _currentTheme = getCurrentThemeModel(context).dykScreenColor;
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: _currentTheme.backgroundColor,
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          AussieSliverAppBar(
            _currentTheme.backgroundColor,
            DYKScreen.data.title,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1.sh,
              child: BlocConsumer<DykCubit, DykState>(
                cubit: cubit,
                listener: (context, state) {
                  if (state is DykLoaded) {
                    if (state.models.length == 1) {
                      setState(() {
                        right = false;
                        left = false;
                      });
                    }
                  }
                },
                builder: (context, state) {
                  if (state is DykLoaded) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (left) Icon(Icons.arrow_left),
                            if (right) Icon(Icons.arrow_right),
                          ],
                        ),
                        Expanded(
                          child: PageView.builder(
                            onPageChanged: (page) {
                              setState(() {
                                if (page > 0 &&
                                    page < state.models.length - 1) {
                                  left = true;
                                  right = true;
                                } else if (page == 0) {
                                  left = false;
                                  right = true;
                                } else if (page == state.models.length - 1) {
                                  left = true;
                                  right = false;
                                }
                              });
                            },
                            itemBuilder: (context, index) {
                              return Center(
                                child: AutoSizeText(
                                  state.models[index].text,
                                  style: TextStyle(
                                    fontSize: 150.sp,
                                  ),
                                ),
                              );
                            },
                            itemCount: state.models.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

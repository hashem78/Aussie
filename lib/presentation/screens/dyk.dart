import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';
import 'package:aussie/state/dyk/cubit/dyk_cubit.dart';
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
      swatchColor: Colors.lime.shade700,
      backgroundColor: Colors.lime.shade600,
    ),
    light: AussieColorData(
      swatchColor: Colors.lime.shade400,
      backgroundColor: Colors.lime.shade300,
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
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: .5.sh,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
              FractionalTranslation(
                translation: Offset(0, 2.3),
                child: Center(
                  child: Text(
                    DYKScreen.data.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 150.sp,
                    ),
                  ),
                ),
              ),
              if (right)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(Icons.arrow_right),
                ),
              if (left)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Icon(Icons.arrow_left),
                ),
            ],
          ),
          BlocConsumer<DykCubit, DykState>(
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
                return SizedBox(
                  height: .5.sh,
                  child: PageView.builder(
                    onPageChanged: (page) {
                      setState(() {
                        if (page > 0 && page < state.models.length - 1) {
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
                );
              }
              return Container(
                margin: EdgeInsets.all(50),
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
}

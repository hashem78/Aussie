import 'package:aussie/constants.dart';

import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  static final title = "Home";
  static final navPath = "/main";
  static final String svgName = "home.svg";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return AussieScaffold(
      drawer: getAppDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AussieSliverAppBar(kausBlue, "Aussie"),
          ],
        ),
      ),
    );
  }
}

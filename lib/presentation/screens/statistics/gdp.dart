import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class GDPScreen extends StatelessWidget {
  static final title = "gdpTitle";
  static final navPath = "/statistics/gdp";
  static final svgName = "gdp.svg";
  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      backgroundColor: Colors.amber,
      drawer: getAppDrawer(context),
      body: ListView(
        addAutomaticKeepAlives: true,
        children: [],
      ),
    );
  }
}

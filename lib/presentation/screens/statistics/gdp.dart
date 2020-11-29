import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:flutter/material.dart';

class GDPScreen extends StatelessWidget {
  static final title = "GDP and the Economy";
  static final navPath = "/statistics/gdp";
  static final svgName = "gdp.svg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      drawer: AussieAppDrawer(),
      body: ListView(
        addAutomaticKeepAlives: true,
        children: [],
      ),
    );
  }
}

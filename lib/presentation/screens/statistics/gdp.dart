import 'package:flutter/material.dart';

class GDPScreen extends StatelessWidget {
  static final title = "GDP and the Economy";
  static final navPath = "/statistics/gdp";
  static final svgName = "gdp.svg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView(
        addAutomaticKeepAlives: true,
        children: [],
      ),
    );
  }
}

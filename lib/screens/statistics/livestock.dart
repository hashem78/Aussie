import 'package:flutter/material.dart';

class LivestockScreen extends StatelessWidget {
  static final title = "Livestock in Australlia";
  static final navPath = "/statistics/livestocks";
  static final svgName = "livestock.svg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) => [
          SliverAppBar(
            backgroundColor: Colors.amber,
            title: Text("Livestock"),
            centerTitle: true,
          ),
        ],
        body: ListView(
          addAutomaticKeepAlives: true,
          children: [],
        ),
      ),
    );
  }
}

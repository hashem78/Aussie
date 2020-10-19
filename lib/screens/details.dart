import 'package:flutter/material.dart';

import 'package:Aussie/widgets/aussie_sliver_appbar.dart';

import '../constants.dart';

class Section extends StatelessWidget {
  final List<Widget> children;
  final Color borderColor;
  const Section({
    Key key,
    @required List<Widget> children,
    this.borderColor = Colors.grey,
  })  : assert(children != null),
        children = children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String title;
  final List<Widget> sections;
  final Widget top;
  final Widget bottom;
  final Color backgroundColor;

  Details({
    Key key,
    Widget top,
    Widget bottom,
    @required this.title,
    @required this.sections,
    this.backgroundColor = kausBlue,
  })  : top = top ?? Container(),
        bottom = bottom ?? Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          AussieSliverAppBar(
            backgroundColor: backgroundColor,
            title: title,
            showHero: false,
            automaticallyImplyLeading: true,
          )
        ],
        body: ListView(
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          children: [
            top,
            ...sections,
            bottom,
          ],
        ),
      ),
    );
  }
}

import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Section extends StatelessWidget {
  final List<Widget> children;
  const Section({
    @required List<Widget> children,
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
          borderRadius: kaussieRadius,
          border: Border.all(color: Colors.grey),
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

  Details({
    @required this.title,
    @required this.sections,
    Widget top,
    Widget bottom,
  })  : top = top ?? Container(),
        bottom = bottom ?? Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kausBlue,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          AussieSliverAppBar(
            title: title,
            showHero: true,
            automaticallyImplyLeading: true,
          )
        ],
        body: ListView(
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
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

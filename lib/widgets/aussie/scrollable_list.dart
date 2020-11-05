import 'package:flutter/material.dart';

class AussieScrollableList extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets childPadding;
  final Axis scrollDirection;
  final double heightFactor;
  const AussieScrollableList({
    Key key,
    @required this.title,
    @required this.children,
    this.childPadding = const EdgeInsets.all(0.0),
    this.scrollDirection = Axis.vertical,
    @required this.heightFactor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightFactor,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: scrollDirection,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: children[index],
        ),
      ),
    );
  }
}

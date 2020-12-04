import 'package:flutter/material.dart';

class AussieScrollableList extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets childPadding;
  final Axis scrollDirection;
  final double heightFactor;

  const AussieScrollableList({
    @required this.children,
    this.childPadding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    @required this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightFactor,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        scrollDirection: scrollDirection,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) => children[index],
      ),
    );
  }
}

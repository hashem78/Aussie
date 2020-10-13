import 'package:flutter/material.dart';

class AussieScrollableList extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets childPadding;
  final Axis scrollDirection;
  final double height;
  const AussieScrollableList({
    Key key,
    @required this.title,
    this.children,
    this.childPadding = const EdgeInsets.all(0.0),
    this.scrollDirection = Axis.vertical,
    @required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 1),
            child: Text(
              title,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        Container(
          height: height,
          padding: EdgeInsets.only(top: 8),
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: scrollDirection,
            children: children
                .map(
                  (e) => Padding(
                    padding: childPadding,
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

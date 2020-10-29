import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          height: (heightFactor / 100).sh,
          padding: EdgeInsets.only(top: 8),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            addAutomaticKeepAlives: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: scrollDirection,
            itemCount: children.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: childPadding,
              child: children[index],
            ),
          ),
        ),
      ],
    );
  }
}

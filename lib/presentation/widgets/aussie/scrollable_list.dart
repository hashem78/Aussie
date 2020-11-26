import 'package:flutter/material.dart';

class AussieScrollableList extends StatefulWidget {
  final List<Widget> children;
  final EdgeInsets childPadding;
  final Axis scrollDirection;
  final double heightFactor;
  final double initalScrollOffset;
  const AussieScrollableList({
    @required this.children,
    this.initalScrollOffset = 0.0,
    this.childPadding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    @required this.heightFactor,
  });

  @override
  _AussieScrollableListState createState() => _AussieScrollableListState();
}

class _AussieScrollableListState extends State<AussieScrollableList> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController =
        ScrollController(initialScrollOffset: widget.initalScrollOffset);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightFactor,
      child: ListView.builder(
        controller: _scrollController,
        addAutomaticKeepAlives: true,
        scrollDirection: widget.scrollDirection,
        itemCount: widget.children.length,
        itemBuilder: (BuildContext context, int index) =>
            widget.children[index],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

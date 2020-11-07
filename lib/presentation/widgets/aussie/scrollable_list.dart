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
        physics: BouncingScrollPhysics(),
        scrollDirection: widget.scrollDirection,
        itemCount: widget.children.length,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
          child: widget.children[index],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

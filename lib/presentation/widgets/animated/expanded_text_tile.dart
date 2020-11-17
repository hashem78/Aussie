import 'dart:math';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

class ExpandingTextTile extends StatefulWidget {
  final String text;
  final String title;
  final Color color;
  final bool showShadow;
  final TextStyle titleStyle;
  final int maxLines;
  final TextOverflow overflow;
  final Color expandedTextColor;
  ExpandingTextTile({
    Color color,
    @required this.title,
    @required this.text,
    this.showShadow = true,
    this.maxLines = 8,
    TextStyle titleStyle,
    this.overflow = TextOverflow.fade,
    this.expandedTextColor = Colors.white,
  })  : color = color ?? Colors.purple.shade700,
        titleStyle = titleStyle ??
            TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            );

  @override
  _ExpandingTextTileState createState() => _ExpandingTextTileState();
}

class _ExpandingTextTileState extends State<ExpandingTextTile>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200 + 100 * Random().nextInt(5)))
      ..forward();
    _animation = Tween<Offset>(begin: Offset(-1, 1), end: Offset.zero)
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _animation,
      child: ColoredBox(
        //margin: EdgeInsets.all(5),
        color: widget.color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: widget.titleStyle,
                    ),
                    ExpandText(
                      widget.text,
                      expandOnGesture: false,
                      overflow: widget.overflow,
                      style: TextStyle(
                        fontSize: 15,
                        color: widget.expandedTextColor,
                      ),
                      maxLines: widget.maxLines,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
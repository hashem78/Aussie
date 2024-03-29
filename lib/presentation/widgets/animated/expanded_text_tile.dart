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
  const ExpandingTextTile({
    Key? key,
    Color? color,
    required this.title,
    required this.text,
    this.showShadow = true,
    this.maxLines = 8,
    TextStyle? titleStyle,
    this.overflow = TextOverflow.fade,
    this.expandedTextColor = Colors.white,
  })  : color = color ?? const Color(0xFF7B1FA2),
        titleStyle = titleStyle ??
            const TextStyle(
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
        super(key: key);

  @override
  _ExpandingTextTileState createState() => _ExpandingTextTileState();
}

class _ExpandingTextTileState extends State<ExpandingTextTile>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200 + 100 * Random().nextInt(5),
      ),
    )..forward();
    _animation = Tween<Offset>(begin: const Offset(-1, 1), end: Offset.zero)
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _animation,
      child: ColoredBox(
        color: widget.color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: widget.titleStyle,
                    ),
                    ExpandText(
                      widget.text,
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

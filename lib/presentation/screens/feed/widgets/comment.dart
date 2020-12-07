import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardComment extends StatefulWidget {
  const FeedCardComment({
    Key key,
  }) : super(key: key);

  @override
  _FeedCardCommentState createState() => _FeedCardCommentState();
}

class _FeedCardCommentState extends State<FeedCardComment>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300 + Random().nextInt(100)),
    )..forward();
    _animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _animation,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text("Hashem"),
        subtitle: Text("Hello"),
        leading: Container(
          width: .1.sw,
          height: .1.sw,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedSocialIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String url;
  const AnimatedSocialIcon(this.icon, this.color, this.url);

  @override
  _AnimatedSocialIconState createState() => _AnimatedSocialIconState();
}

class _AnimatedSocialIconState extends State<AnimatedSocialIcon>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController controller;
  Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + 100 * Random().nextInt(5)))
      ..forward();
    animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: animation,
      child: GestureDetector(
        child: Container(
          child: Icon(widget.icon, color: widget.color, size: 30),
        ),
        onTap: () async {
          if (await canLaunch(widget.url)) {
            await launch(widget.url);
          } else {
            throw 'Could not launch ${widget.url}';
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

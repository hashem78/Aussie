import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class AussieScaffold extends StatelessWidget {
  final Widget body;
  final Color backgroundColor;
  final Widget drawer;
  final Widget appBar;
  final GlobalKey<ScaffoldState> state;
  final Widget floatingActionButton;
  const AussieScaffold({
    this.body,
    this.backgroundColor,
    this.drawer,
    this.appBar,
    this.state,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: state,
      drawer: drawer,
      backgroundColor: backgroundColor,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: DoubleBackToCloseApp(
        child: body,
        snackBar: const SnackBar(content: Text("Tap back again to close app.")),
      ),
    );
  }
}

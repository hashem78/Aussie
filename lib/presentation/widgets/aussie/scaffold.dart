import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:aussie/util/functions.dart';

class AussieScaffold extends StatelessWidget {
  final Widget? body;
  final Color? backgroundColor;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final GlobalKey<ScaffoldState>? state;
  final Widget? floatingActionButton;
  const AussieScaffold({
    Key? key,
    this.body,
    this.backgroundColor,
    this.drawer,
    this.appBar,
    this.state,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: state,
      drawer: drawer,
      backgroundColor: backgroundColor,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(
            getTranslation(context, 'tapbackToClose'),
          ),
        ),
        child: body!,
      ),
    );
  }
}

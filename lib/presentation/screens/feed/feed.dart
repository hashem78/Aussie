
import 'package:aussie/presentation/screens/feed/feeds/public_feed.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

import 'package:aussie/presentation/widgets/aussie/aussie_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      drawer: const AussieAppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          getTranslation(context, 'feedScreenTitle'),
          style: TextStyle(
            fontSize: 100.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0,
      ),
      body: const PublicFeed(),
    );
  }
}

import 'package:evento/presentation/screens/feed/feeds/public_feed.dart';
import 'package:evento/presentation/widgets/app_drawer.dart';
import 'package:evento/presentation/widgets/scaffold.dart';
import 'package:evento/util/functions.dart';
import 'package:flutter/material.dart';

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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: PublicFeed(),
      ),
    );
  }
}

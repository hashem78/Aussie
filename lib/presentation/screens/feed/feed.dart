import 'package:aussie/presentation/screens/feed/tabs/events/tab.dart';
import 'package:aussie/presentation/screens/feed/tabs/home/tab.dart';
import 'package:aussie/presentation/widgets/aussie/scaffold.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return SafeArea(
      child: AussieScaffold(
        drawer: getAppDrawer(context),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverSafeArea(
              sliver: SliverAppBar(
                primary: true,
                pinned: true,
                centerTitle: true,
                title: Text(
                  "Feed",
                  style:
                      TextStyle(fontSize: 60.sp, fontWeight: FontWeight.w400),
                ),
                elevation: 0,
                bottom: TabBar(
                  controller: controller,
                  tabs: [
                    Icon(Icons.home),
                    Icon(Icons.event),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: controller,
            children: [
              HomeTab(),
              EventsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

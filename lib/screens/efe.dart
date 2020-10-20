import 'package:Aussie/screens/entertainment.dart';
import 'package:Aussie/screens/explore.dart';
import 'package:Aussie/screens/food_drinks.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class EFEScreen extends StatefulWidget {
  static final title = "Explore";

  @override
  _EFEScreenState createState() => _EFEScreenState();
}

class _EFEScreenState extends State<EFEScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();
  var tabs = [ExploreScreen(), Cuisine(), Entertainment()];
  void onPageChanged(int page) {
    setState(
      () {
        this.currentIndex = page;
        this._controller.jumpToPage(page);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xff141414),
        selectedIndex: currentIndex,
        itemCornerRadius: 0,
        curve: Curves.easeInOut,
        onItemSelected: onPageChanged,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.explore),
            title: Text('Explore'),
            activeColor: kausBlue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.local_pizza),
            title: Text(
              'Food|Drinks',
              maxLines: 2,
            ),
            activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.movie),
            title: Text(
              'Entertainment',
              style: TextStyle(fontSize: 12),
            ),
            activeColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: onPageChanged,
        children: tabs,
      ),
    );
  }
}

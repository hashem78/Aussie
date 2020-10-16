import 'package:Aussie/screens/explore.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../size_config.dart';

class MainScreen extends StatefulWidget {
  static final title = "Explore";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();
  var tabs = [ExploreScreen()];
  void onPageChanged(int page) {
    setState(() {
      this.currentIndex = page;
      this._controller.animateToPage(page,
          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: kausBlue,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavyBar(
          backgroundColor: Color(0xff141414),
          selectedIndex: currentIndex,
          itemCornerRadius: 8,
          curve: Curves.easeIn,
          showElevation: false,
          onItemSelected: onPageChanged,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explore'),
              activeColor: kausBlue,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.coffee),
              title: Text(
                'Food & Drinks',
                maxLines: 2,
              ),
              activeColor: Colors.amberAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Messages test for mes teset test test ',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
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

Widget buildImage(imageUrl) => CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.lightBlueAccent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );

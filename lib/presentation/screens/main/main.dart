import 'package:aussie/constants.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/screens/main/details.dart';
import 'package:aussie/presentation/screens/main/entertainment.dart';
import 'package:aussie/presentation/screens/main/events.dart';
import 'package:aussie/presentation/screens/main/food_drinks.dart';
import 'package:aussie/presentation/screens/main/people.dart';
import 'package:aussie/presentation/screens/main/places.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scrollable_list.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  static final title = "Explore";
  static final navPath = "/main";
  static Widget buildTiles(
    List<MainScreenDetailsModel> models, {
    double widthFactor,
    double heightFactor,
    double swatchWidthFactor,
    double swatchHeightFactor,
    double titleImageHeight,
    double listHeightFactor,
    double listScrollOffset,
    Color swatchColor = Colors.transparent,
  }) {
    titleImageHeight = titleImageHeight ?? .5.sh;
    return Builder(
      builder: (BuildContext context) {
        return AussieScrollableList(
          heightFactor: listHeightFactor,
          scrollDirection: Axis.horizontal,
          initalScrollOffset: listScrollOffset,
          children: models.map(
            (model) {
              var _key = UniqueKey().toString();
              return SizedTile.withDetails(
                widthFactor: widthFactor,
                heightFactor: heightFactor,
                swatchWidthFactor: swatchWidthFactor,
                swatchHeightFactor: swatchHeightFactor,
                title: model.title,
                swatchColor: swatchColor,
                image: Hero(
                  tag: _key,
                  child: buildImage(model.titleImageUrl),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => EFEDetails(
                      model: model,
                      tag: _key,
                      titleImageHeight: titleImageHeight,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();
  var tabs = [
    PeopleScreen(),
    PlacesScreen(),
    EventsScreen(),
    FoodScreen(),
    Entertainment(),
  ];
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
    ScreenUtil.init(context);
    return Scaffold(
      drawer: AussieAppDrawer(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        itemCornerRadius: 0,
        showElevation: true,
        containerHeight: .08.sh,
        curve: Curves.easeInOut,
        onItemSelected: onPageChanged,
        items: _bottomNavyBarItems,
      ),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            print(innerBoxIsScrolled);
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: AussieSliverAppBar(),
              ),
            ];
          },
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: onPageChanged,
            children: tabs,
          ),
        ),
      ),
    );
  }

  static final List<BottomNavyBarItem> _bottomNavyBarItems = [
    BottomNavyBarItem(
      icon: Icon(Icons.people),
      title: AutoSizeText(
        'People',
        maxLines: 1,
      ),
      activeColor: Colors.pink,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.place),
      title: AutoSizeText(
        'Places',
        maxLines: 1,
      ),
      activeColor: Colors.red,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.event),
      title: AutoSizeText(
        'Events',
        maxLines: 1,
      ),
      activeColor: kausBlue,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.local_pizza),
      title: AutoSizeText(
        'Food',
        maxLines: 1,
      ),
      activeColor: Colors.green,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.movie),
      title: AutoSizeText(
        'Entertainment',
        maxLines: 1,
      ),
      activeColor: Colors.grey,
      textAlign: TextAlign.center,
    ),
  ];
}

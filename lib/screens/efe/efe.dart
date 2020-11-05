import 'package:Aussie/models/efe/efe.dart';
import 'package:Aussie/screens/efe/details.dart';
import 'package:Aussie/screens/efe/entertainment.dart';
import 'package:Aussie/screens/efe/events.dart';
import 'package:Aussie/screens/efe/people.dart';
import 'package:Aussie/screens/efe/food_drinks.dart';
import 'package:Aussie/screens/efe/places.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/aussie/scrollable_list.dart';
import 'package:Aussie/widgets/sized_tile.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class EFEScreen extends StatefulWidget {
  static final title = "Explore";
  static final navPath = "/main/efe";
  static Widget buildEFETiles(
    String title,
    List<EFEModel> models, {
    double widthFactor,
    double heightFactor,
    double listHeightFactor,
    double swatchWidthFactor,
    double swatchHeightFactor,
    double titleImageHeight,
    Color swatchColor = Colors.transparent,
  }) {
    titleImageHeight = titleImageHeight ?? .5.sh;
    return Builder(
      builder: (BuildContext context) => AussieScrollableList(
        title: title,
        heightFactor: listHeightFactor,
        scrollDirection: Axis.horizontal,
        children: models
            .map(
              (model) => SizedTile.withDetails(
                widthFactor: widthFactor,
                heightFactor: heightFactor,
                swatchWidthFactor: swatchWidthFactor,
                swatchHeightFactor: swatchHeightFactor,
                title: model.title,
                swatchColor: swatchColor,
                image: buildImage(model.titleImageUrl),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => EFEDetails(
                      model: model,
                      titleImageHeight: titleImageHeight,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  _EFEScreenState createState() => _EFEScreenState();
}

class _EFEScreenState extends State<EFEScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();
  var tabs = [
    PeopleScreen(),
    PlacesScreen(),
    EventsScreen(),
    FoodAndDrinks(),
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
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        itemCornerRadius: 0,
        showElevation: true,
        curve: Curves.easeInOut,
        onItemSelected: onPageChanged,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('People'),
            activeColor: kausBlue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.place),
            title: Text('Places'),
            activeColor: kausBlue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.event),
            title: Text('Events'),
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

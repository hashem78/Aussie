import 'package:aussie/constants.dart';
import 'package:aussie/presentation/screens/dyk.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/main/entertainment.dart';
import 'package:aussie/presentation/screens/main/events.dart';
import 'package:aussie/presentation/screens/main/food_drinks.dart';
import 'package:aussie/presentation/screens/main/people.dart';
import 'package:aussie/presentation/screens/main/places.dart';
import 'package:aussie/presentation/screens/settings/settings.dart';
import 'package:aussie/presentation/screens/statistics/energy.dart';
import 'package:aussie/presentation/screens/statistics/gdp.dart';
import 'package:aussie/presentation/screens/statistics/heducation.dart';
import 'package:aussie/presentation/screens/statistics/livestock.dart';
import 'package:aussie/presentation/screens/statistics/religion.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

@immutable
class _DrawerItemModel extends Equatable {
  final String navPath;
  final String svgName;
  final String title;
  final Color iconColor;
  final bool assumeOrder;

  _DrawerItemModel({
    @required this.navPath,
    @required this.svgName,
    @required this.title,
    this.assumeOrder = false,
    this.iconColor = Colors.black,
  }) : assert(
          navPath != null &&
              svgName != null &&
              title != null &&
              assumeOrder != null,
        );

  @override
  List<Object> get props => [navPath, svgName];
}

class _DrawerSection extends StatelessWidget {
  final List<_DrawerItemModel> models;
  final IconData sectionIcon;
  final String sectionTitle;
  final Color sectionTitleColor;
  final Color tilesColor;
  const _DrawerSection({
    this.models,
    this.sectionIcon,
    this.sectionTitle,
    this.sectionTitleColor = Colors.amber,
    this.tilesColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DrawerSectionTitle(
          iconData: sectionIcon,
          title: sectionTitle,
          color: sectionTitleColor,
        ),
        ...models
            .map(
              (e) => _DrawerItem(
                e,
                color: tilesColor,
              ),
            )
            .toList(),
      ],
    );
  }
}

class AussieAppDrawer extends StatelessWidget {
  static get statisticsModels => [
        _DrawerItemModel(
          navPath: ReligionScreen.navPath,
          svgName: ReligionScreen.svgName,
          title: ReligionScreen.title,
        ),
        _DrawerItemModel(
          navPath: LivestockScreen.navPath,
          svgName: LivestockScreen.svgName,
          title: LivestockScreen.title,
          iconColor: Colors.pink,
        ),
        _DrawerItemModel(
          navPath: HEducationScreen.navPath,
          svgName: HEducationScreen.svgName,
          title: HEducationScreen.title,
        ),
        _DrawerItemModel(
          navPath: EnergyScreen.navPath,
          svgName: EnergyScreen.svgName,
          title: EnergyScreen.title,
          iconColor: Colors.blue.shade900,
        ),
        _DrawerItemModel(
          navPath: GDPScreen.navPath,
          svgName: GDPScreen.svgName,
          title: GDPScreen.title,
          iconColor: Colors.orange,
        ),
      ];
  static get inAus => [
        _DrawerItemModel(
          navPath: PeopleScreen.data.navPath,
          svgName: PeopleScreen.data.svgName,
          title: PeopleScreen.data.title,
          iconColor: Colors.blue,
        ),
        _DrawerItemModel(
          navPath: PlacesScreen.data.navPath,
          svgName: PlacesScreen.data.svgName,
          title: PlacesScreen.data.title,
          iconColor: Colors.brown,
        ),
        _DrawerItemModel(
          navPath: EventsScreen.data.navPath,
          svgName: EventsScreen.data.svgName,
          title: EventsScreen.data.title,
          iconColor: Colors.lightGreen,
        ),
        _DrawerItemModel(
          navPath: FoodScreen.data.navPath,
          svgName: FoodScreen.data.svgName,
          title: FoodScreen.data.title,
          iconColor: Colors.lime,
        ),
        _DrawerItemModel(
          navPath: EntertainmentScreen.data.navPath,
          svgName: EntertainmentScreen.data.svgName,
          title: EntertainmentScreen.data.title,
          iconColor: Colors.lightBlue,
        ),
      ];
  static get infoModels => [
        _DrawerItemModel(
          navPath: FaunaScreen.data.navPath,
          svgName: FaunaScreen.data.svgName,
          title: FaunaScreen.data.title,
          iconColor: Colors.brown,
        ),
        _DrawerItemModel(
          navPath: FloraScreen.data.navPath,
          svgName: FloraScreen.data.svgName,
          title: FloraScreen.data.title,
          iconColor: Colors.green.shade900,
        ),
        _DrawerItemModel(
          navPath: WeatherScreen.data.navPath,
          svgName: WeatherScreen.data.svgName,
          title: WeatherScreen.data.title,
          iconColor: Colors.lightBlue,
        ),
        _DrawerItemModel(
          navPath: TeritoriesScreen.data.navPath,
          svgName: TeritoriesScreen.data.svgName,
          title: TeritoriesScreen.data.title,
          iconColor: Colors.green,
        ),
        _DrawerItemModel(
          navPath: NaturalParksScreen.data.navPath,
          svgName: NaturalParksScreen.data.svgName,
          title: NaturalParksScreen.data.title,
          iconColor: Colors.green.shade900,
        ),
        _DrawerItemModel(
          navPath: DYKScreen.data.navPath,
          svgName: DYKScreen.data.svgName,
          title: DYKScreen.data.title,
          iconColor: Colors.yellow,
        ),
      ];
  final List<_DrawerSection> sections = [
    _DrawerSection(
      sectionIcon: Icons.map,
      sectionTitle: "In Australia",
      sectionTitleColor: Colors.green,
      models: inAus,
    ),
    _DrawerSection(
      sectionIcon: Icons.info,
      sectionTitle: "Info",
      sectionTitleColor: kausBlue,
      tilesColor: Colors.blue,
      models: infoModels,
    ),
    _DrawerSection(
      sectionIcon: Icons.wallet_travel,
      sectionTitle: "Statistics",
      sectionTitleColor: kausRed,
      tilesColor: Colors.blue,
      models: statisticsModels,
    ),
    _DrawerSection(
      sectionIcon: Icons.miscellaneous_services,
      sectionTitle: "Misc",
      sectionTitleColor: kausBlue,
      tilesColor: Colors.blue,
      models: [
        _DrawerItemModel(
          title: SettingsScreen.title,
          svgName: SettingsScreen.svgName,
          navPath: SettingsScreen.navPath,
          iconColor: Colors.grey,
          assumeOrder: true,
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 5,
            forceElevated: true,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: .23.sh,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  top: 0,
                  child: Container(
                    color: kausBlue,
                    child: SvgPicture.asset(
                      'assests/images/au.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Aussie",
                    style: TextStyle(
                      fontSize: 100.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final int itemIndex = index ~/ 2;
                if (index.isEven) {
                  return sections[itemIndex];
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                );
              },
              childCount: math.max(0, sections.length * 2 - 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final _DrawerItemModel model;

  final Color color;

  const _DrawerItem(
    this.model, {
    this.color = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              if (!model.assumeOrder) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(model.navPath, (route) => false);
              } else {
                Navigator.of(context).pushNamed(model.navPath);
              }
            },
            splashColor: Colors.red,
            child: Ink(
              child: ListTile(
                //tileColor: Theme.of(context).secondaryHeaderColor,
                leading: SvgPicture.asset(
                  "assests/images/${model.svgName}",
                  height: 75.sp,
                  color: model.iconColor,
                ),
                title: Text(
                  model.title,
                  style: TextStyle(fontSize: 60.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerSectionTitle extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String title;
  const _DrawerSectionTitle({
    @required this.iconData,
    @required this.title,
    this.color,
  }) : assert(iconData != null && title != null);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Icon(
              iconData,
              size: 80.sp,
              color: color,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 80.sp,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

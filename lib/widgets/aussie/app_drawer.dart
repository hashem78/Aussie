import 'package:Aussie/screens/dyk.dart';
import 'package:Aussie/screens/info/fauna.dart';
import 'package:Aussie/screens/info/natural_parks/natural_parks.dart';
import 'package:Aussie/screens/info/teritories/teritories.dart';
import 'package:Aussie/screens/info/weather/weather.dart';
import 'package:Aussie/screens/statistics/energy.dart';
import 'package:Aussie/screens/statistics/gdp.dart';
import 'package:Aussie/screens/statistics/heducation.dart';
import 'package:Aussie/screens/statistics/livestock.dart';
import 'package:Aussie/screens/statistics/religion.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/info/flora.dart';

@immutable
class _DrawerItemModel extends Equatable {
  final String navPath;
  final String svgName;
  final String title;
  _DrawerItemModel({
    @required this.navPath,
    @required this.svgName,
    @required this.title,
  }) : assert(
          navPath != null && svgName != null && title != null,
        );

  @override
  List<Object> get props => [navPath, svgName];
}

class _DrawerSection extends StatelessWidget {
  final List<_DrawerItemModel> models;
  final IconData sectionIcon;
  final String sectionTitle;
  final Color sectionTitleColor;
  const _DrawerSection({
    this.models,
    this.sectionIcon,
    this.sectionTitle,
    this.sectionTitleColor = Colors.amber,
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
        ...models.map((e) => _DrawerItem(e)).toList(),
        buildDivider(),
      ],
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.white,
        thickness: 5,
      ),
    );
  }
}

class AussieAppDrawer extends StatelessWidget {
  final List<_DrawerSection> sections = [
    _DrawerSection(
      sectionIcon: Icons.info,
      sectionTitle: "Info",
      sectionTitleColor: Colors.amber,
      models: [
        _DrawerItemModel(
          navPath: FaunaScreen.navPath,
          svgName: FaunaScreen.svgName,
          title: FaunaScreen.title,
        ),
        _DrawerItemModel(
          navPath: FloraScreen.navPath,
          svgName: FloraScreen.svgName,
          title: FloraScreen.title,
        ),
        _DrawerItemModel(
          navPath: WeatherScreen.navPath,
          svgName: WeatherScreen.svgName,
          title: WeatherScreen.title,
        ),
        _DrawerItemModel(
          navPath: TeritoriesScreen.navPath,
          svgName: TeritoriesScreen.svgName,
          title: TeritoriesScreen.title,
        ),
        _DrawerItemModel(
          navPath: NaturalParksScreen.navPath,
          svgName: NaturalParksScreen.svgName,
          title: NaturalParksScreen.title,
        ),
        _DrawerItemModel(
          navPath: DYKScreen.navPath,
          svgName: DYKScreen.svgName,
          title: DYKScreen.title,
        ),
      ],
    ),
    _DrawerSection(
      sectionIcon: Icons.wallet_travel,
      sectionTitle: "Statistics",
      sectionTitleColor: Colors.amber,
      models: [
        _DrawerItemModel(
          navPath: ReligionScreen.navPath,
          svgName: ReligionScreen.svgName,
          title: ReligionScreen.title,
        ),
        _DrawerItemModel(
          navPath: LivestockScreen.navPath,
          svgName: LivestockScreen.svgName,
          title: LivestockScreen.title,
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
        ),
        _DrawerItemModel(
          navPath: GDPScreen.navPath,
          svgName: GDPScreen.svgName,
          title: GDPScreen.title,
        ),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: kausBlue,
      ),
      child: Drawer(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              stretch: true,
              automaticallyImplyLeading: false,
              expandedHeight: .24.sh,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Aussie",
                  style:
                      TextStyle(fontSize: 70.sp, fontWeight: FontWeight.w700),
                ),
                centerTitle: true,
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: Container(
                  color: kausBlue,
                  child: SvgPicture.asset(
                    'assests/images/au.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => sections[index],
                childCount: sections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final _DrawerItemModel model;

  const _DrawerItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
      child: Ink(
        color: Colors.lightBlue,
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(model.navPath),
          // tileColor: Colors.purple,
          leading: SvgPicture.asset(
            "assests/images/${model.svgName}",
            height: 30,
          ),
          title: Text(
            model.title,
            style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
          ),
        ),
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
              size: 30,
              color: color,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 100.sp,
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

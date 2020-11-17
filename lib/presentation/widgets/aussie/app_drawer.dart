import 'package:aussie/constants.dart';
import 'package:aussie/presentation/screens/dyk.dart';
import 'package:aussie/presentation/screens/info/fauna.dart';
import 'package:aussie/presentation/screens/info/flora.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
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

  _DrawerItemModel({
    @required this.navPath,
    @required this.svgName,
    @required this.title,
    this.iconColor = Colors.black,
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
        ...models.map((e) => _DrawerItem(e, color: tilesColor)).toList(),
      ],
    );
  }
}

class AussieAppDrawer extends StatelessWidget {
  final List<_DrawerSection> sections = [
    _DrawerSection(
      sectionIcon: Icons.info,
      sectionTitle: "Info",
      sectionTitleColor: kausBlue,
      tilesColor: Colors.blue,
      models: [
        _DrawerItemModel(
          navPath: FaunaScreen.navPath,
          svgName: FaunaScreen.svgName,
          title: FaunaScreen.title,
          iconColor: Colors.brown,
        ),
        _DrawerItemModel(
          navPath: FloraScreen.navPath,
          svgName: FloraScreen.svgName,
          title: FloraScreen.title,
          iconColor: Colors.green.shade900,
        ),
        _DrawerItemModel(
          navPath: WeatherScreen.navPath,
          svgName: WeatherScreen.svgName,
          title: WeatherScreen.title,
          iconColor: Colors.white70,
        ),
        _DrawerItemModel(
          navPath: TeritoriesScreen.navPath,
          svgName: TeritoriesScreen.svgName,
          title: TeritoriesScreen.title,
          iconColor: Colors.brown.shade900,
        ),
        _DrawerItemModel(
          navPath: NaturalParksScreen.navPath,
          svgName: NaturalParksScreen.svgName,
          title: NaturalParksScreen.title,
          iconColor: Colors.green.shade900,
        ),
        _DrawerItemModel(
          navPath: DYKScreen.navPath,
          svgName: DYKScreen.svgName,
          title: DYKScreen.title,
          iconColor: Colors.yellow,
        ),
      ],
    ),
    _DrawerSection(
      sectionIcon: Icons.wallet_travel,
      sectionTitle: "Statistics",
      sectionTitleColor: kausRed,
      tilesColor: Colors.blue,
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
          iconColor: Colors.white70,
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
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Drawer(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            stretch: true,
            pinned: true,
            forceElevated: true,
            automaticallyImplyLeading: false,
            expandedHeight: .25.sh,
            flexibleSpace: Stack(
              children: [
                FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
                Positioned.fill(
                  child: Container(
                    color: kausBlue,
                    child: SvgPicture.asset(
                      'assests/images/au.svg',
                      fit: BoxFit.fitWidth,
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
                    thickness: 5,
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

class _DrawerItem extends StatefulWidget {
  final _DrawerItemModel model;
  final Color color;

  const _DrawerItem(
    this.model, {
    this.color = Colors.lightBlue,
  });

  @override
  __DrawerItemState createState() => __DrawerItemState();
}

class __DrawerItemState extends State<_DrawerItem>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + math.Random().nextInt(3) * 100))
      ..forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animationController,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        child: Ink(
          color: widget.color,
          child: ListTile(
            onTap: () => Navigator.of(context).pushNamed(widget.model.navPath),
            // tileColor: Colors.purple,
            leading: SvgPicture.asset(
              "assests/images/${widget.model.svgName}",
              height: 30,
              color: widget.model.iconColor,
            ),
            title: Text(
              widget.model.title,
              style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
